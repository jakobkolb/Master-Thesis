MODULE push

USE global

IMPLICIT NONE

CONTAINS

SUBROUTINE move_particles

    REAL(8), DIMENSION(3,npar)  :: erand, force
    REAL(8), DIMENSION(3,npar)  :: nrand1, nrand2
    REAL(8), DIMENSION(npar)  :: r1, r2
    INTEGER                     :: i, j
    REAL(8)                     :: Ua, Ub, a, b

    force = 0
    parold = par

    !Calculate parameters for ideal barrier

    Ua = 1+l 
    Ub = 1+(1+g)*l

    !Calculate parameters for gaussian barrier

    a = (Ua+Ub)/2.0
    b = (Ub-Ua)/2.0

    !Calculate particle distance from origin before step

    !$OMP PARALLEL DO
        DO i = 1,npar
            r1(i) = SQRT(DOT_PRODUCT(par(1:3,i),par(1:3,i)))
        ENDDO
    !$OMP END PARALLEL DO

    CALL RANDOM_NUMBER(nrand1)
    CALL RANDOM_NUMBER(nrand2)

    !Compute gaussian random numbers for random force using Box Muller transform

    !$OMP PARALLEL DO
    DO i = 1,npar
        DO j = 1,3
            erand(j,i) = SQRT(-2*LOG(nrand1(j,i)))*COS(2*pi*nrand2(j,i))
        ENDDO
    ENDDO
    !$OMP END PARALLEL DO

    !Calculate effective displacement due to thermal noise

    erand = SQRT(2*D*dt)*erand

    !Calculate force on particles in case of linear potential

    IF(potential_shape .EQ. 'lin') THEN
    !$OMP PARALLEL DO
        DO i = 1,npar
            !Did it cross from outside, did it see the barrier?
            IF(r1(i)<Ub .AND. r1(i)>Ua+g*l*0.5.AND. par(4,i)==1) THEN
                !Then force points out
                force(:,i) = par(:,i)/r1(i)*2.0*Ua/g/l*dt
            !Did it cross from inside, did it see the barrier?
            ELSEIF(r1(i)>Ua .AND. r1(i)>Ua+g*l*0.5 .AND. par(4,i)==1) THEN
                !Then force points in
                force(:,i) = par(:,i)/r1(i)*2.0*Ua/g/l*dt
            ENDIF
        ENDDO
    !$OMP END PARALLEL DO
    ENDIF
    !Calculated force on particles in case of gaussian potential as f = -grad(U)

    IF(potential_shape .EQ. 'gau') THEN
        !$OMP PARALLEL DO
        DO i = 1,npar
            IF(par(4,i)==1)THEN
                force(:,i) = -par(:,i)/r1(i)*(EXP(-((-a+r1(i))/b)**Un)*Un*((-a+r1(i))/b)**Un*U1)/(a-r1(i)) 
            ENDIF
        ENDDO
        !$OMP END PARALLEL DO
    ENDIF

    !Apply random force to Particles (do step)

    !$OMP PARALLEL DO
    DO i = 1,npar
        DO j = 1,3
            par(j,i) = par(j,i) + erand(j,i) + force(j,i)
        ENDDO
    ENDDO
    !$OMP END PARALLEL DO

    !Calculate particle distance from origin after step

    !$OMP PARALLEL DO
        DO i = 1,npar
            r2(i) = SQRT(DOT_PRODUCT(par(1:3,i),par(1:3,i)))
        ENDDO
    !$OMP END PARALLEL DO

    !Check if particles crossed boundaries of potential
    IF(potential_shape .EQ. 'box') THEN
    !$OMP PARALLEL DO
    DO i = 1,npar
        !Did it cross from outside, did it see the barrier?
        IF(r1(i)>Ub .AND. r2(i)<Ub .AND. par(4,i)==1) THEN
            !Then throw it out again!
            par(1:3,i) =  par(1:3,i)/SQRT(DOT_PRODUCT(par(1:3,i),par(1:3,i)))&
                        *(2*Ub-r2(i))
        !Did it cross from inside, did it see the barrier?
        ELSEIF(r1(i)<Ua .AND. r2(i)>Ua .AND. par(4,i)==1) THEN
            !Then keep it in!
            par(1:3,i) =  par(1:3,i)/SQRT(DOT_PRODUCT(par(1:3,i),par(1:3,i)))&
                        *(2*Ua-r2(i))
        ENDIF
    ENDDO
    !$OMP END PARALLEL DO
    ENDIF
    

END SUBROUTINE move_particles

SUBROUTINE maintain_boundary_conditions(counter)

    REAL(8), DIMENSION(3)   :: px   !closest point on trajectory to sink
    REAL(8), DIMENSION(3)   :: A, B, AB !Work vectors
    REAL(8)                 :: Rr   !minimum distance of Particle to sink
    REAL(8), DIMENSION(3)   :: dr   !random displacement vector
    REAL(8), DIMENSION(4)   :: rand
    REAL(8)                 :: theta, phi !angles for random sphere point picking
    INTEGER, INTENT(out)    :: counter !counter for absorbed particles
    INTEGER                 :: i, j, icase
    REAL(8), DIMENSION(npar):: dmsqr
    REAL(8), DIMENSION(npar):: dmr
    counter = 0

    !$OMP DO REDUCTION(+:counter) PRIVATE(Rr, rand, dr, A, B, AB, px, theta, phi)
    DO i = 1,npar

        !Calculate closest point of particle trajectory to sink

        A = parold(1:3,i)
        B = par(1:3,i)
        AB = parold(1:3,i) - par(1:3,i)

        px = A + DOT_PRODUCT(A,AB)*AB/DOT_PRODUCT(AB,AB)

        IF( DOT_PRODUCT((px-A),(px-B)) < 0 )THEN
            Rr = SQRT(DOT_PRODUCT(px,px))
        ELSEIF( DOT_PRODUCT((px-A),(px-B)) >= 0 )THEN
            Rr = SQRT(DOT_PRODUCT(par(1:3,i),par(1:3,i)))
        ENDIF

        !Set particles to domain boundary (ensure steady state solution
        !when they hit the Sink and count them for rate statistics

        IF( Rr < Rs )THEN

            !increase counter for absorbed particles

            counter = counter + 1

            !calculate random possition at domain boundary

            CALL RANDOM_NUMBER(rand)
            theta = 2*pi*rand(2)
            phi   = ACOS(2*rand(3) - 1)
            dr(1) = COS(phi)*SIN(theta)
            dr(2) = SIN(phi)*SIN(theta)
            dr(3) = COS(theta) 
            par(1:3,i) = (Rs + Rd - Rr)*dr
        ELSEIF( Rr > Rd )THEN

        !Reset particles to some random place at the boundary if they exceed the
        !simulation domain to have zero flux through domain boundary 

            CALL RANDOM_NUMBER(rand)
            theta = 2*pi*rand(2)
            phi   = ACOS(2*rand(3) - 1)
            dr(1) = COS(phi)*SIN(theta)
            dr(2) = SIN(phi)*SIN(theta)
            dr(3) = COS(theta) 
            par(1:3,i) = (2*Rd - Rr)*dr
        ENDIF
    ENDDO
    !$OMP END DO

END SUBROUTINE maintain_boundary_conditions

SUBROUTINE update_state_of_potential

    INTEGER                 :: i
    REAL, DIMENSION(npar)   :: rand
    REAL                    :: tmp

    IF(fmode == 0) THEN
        CALL RANDOM_NUMBER(tmp)
        rand = tmp
    ELSEIF(fmode == 1) THEN
        CALL RANDOM_NUMBER(rand)
    ENDIF
    !$OMP PARALLEL DO
    DO i = 1,npar
        IF(rand(i) < K01*dt .AND. par(4,i) == 0)THEN
            par(4,i) = 1
            CYCLE
        ELSEIF(rand(i) < K10*dt .AND. par(4,i) == 1)THEN
            par(4,i) = 0
        ENDIF
    ENDDO
    !$OMP END PARALLEL DO
END SUBROUTINE update_state_of_potential

END MODULE push
