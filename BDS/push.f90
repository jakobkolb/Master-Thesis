MODULE push

USE global

IMPLICIT NONE

CONTAINS

SUBROUTINE move_particles

    REAL(8), DIMENSION(3,npar)  :: erand
    REAL(8), DIMENSION(3,npar)  :: nrand1, nrand2
    REAL(8), DIMENSION(3,npar)  :: f_eff
    INTEGER                     :: i, j

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

    !Calculate effective interaction forces
    !f_eff = -D/KT*grad_U*dt

    f_eff = 0
    !$OMP PARALLEL DO
    DO i = 1,npar
        CALL grad_U(par(:,i), f_eff(:,i))
    ENDDO
    !$OMP END PARALLEL DO

    !Calculate sigma for random force using the Einstein Smoluchowski relation

    erand = SQRT(2*D*dt)*erand

    !Apply random force to Particles


    !$OMP PARALLEL DO
    DO i = 1,npar
        DO j = 1,3
            par(j,i) = par(j,i) +f_eff(j,i) + erand(j,i)
        ENDDO
    ENDDO
    !$OMP END PARALLEL DO


END SUBROUTINE move_particles

SUBROUTINE grad_U(X, f_eff) 

    REAL(8), DIMENSION(4), INTENT(in)   :: X
    REAL(8), DIMENSION(3)               :: Rn, R
    REAL(8)                             :: Rr, grad_Ur, a, b
    REAL(8), DIMENSION(3), INTENT(out)  :: f_eff
    INTEGER                             :: state

    R = X(1:3)
    state = X(4)

    Rr = SQRT(DOT_PRODUCT(R,R))
    Rn = R/Rr

    a = Rs + (Ua + Ub)*0.5  !gap
    b = Ub-Ua               !width
    a = a + b/2.0
    !a: gap between sink and barrier+1/2 barrier width, b:barrier width

    IF(state == 0) THEN
        grad_Ur = -U0*EXP(-((Rr-(a+b/2.0))*2.0/b)**(2*Un))*2.0*Un/b*((Rr-(a+b/2.0))*2.0/b)**(2*Un-1)
    ELSEIF(state == 1) THEN
        grad_Ur = -U1*EXP(-((Rr-(a+b/2.0))*2.0/b)**(2*Un))*2.0*Un/b*((Rr-(a+b/2.0))*2.0/b)**(2*Un-1)
    ENDIF
    f_eff = -D/KT*grad_Ur*dt*Rn

END SUBROUTINE grad_U

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
