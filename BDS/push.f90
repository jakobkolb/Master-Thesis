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

SUBROUTINE grad_U(R, f_eff) 

    REAL(8), DIMENSION(3), INTENT(in)   :: R
    REAL(8), DIMENSION(3)               :: Rn
    REAL(8)                             :: Rr, grad_Ur, a, b
    REAL(8), DIMENSION(3), INTENT(out)  :: f_eff

    Rr = SQRT(DOT_PRODUCT(R,R))
    Rn = R/Rr

    a = Rs + Ua + 0.5*Ub
    b = Ub

    grad_Ur = -4*Un*U0*((2/b*(Rr-a))**(2*Un-1))/b/((2/b*(Rr-a))**(2*Un) + 1)**2
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

    !calculate mean square displacement and mean displacement to check...

    DO i = 1,npar
        dmsqr(i) = DOT_PRODUCT(par(:,i) - parold(:,i), par(:,i) - parold(:,i))
        dmr(i)   = SUM(par(:,i) - parold(:,i))
    ENDDO

    msqd = msqd + SUM(dmsqr)/npar
    md   = md   + SUM(dmr)/npar


    !$OMP DO REDUCTION(+:counter) PRIVATE(Rr, rand, dr, A, B, AB, px, theta, phi)
    DO i = 1,npar

        !Calculate closest point of particle trajectory to sink

        A = parold(:,i)
        B = par(:,i)
        AB = parold(:,i) - par(:,i)

        px = A + DOT_PRODUCT(A,AB)*AB/DOT_PRODUCT(AB,AB)

        IF( DOT_PRODUCT((px-A),(px-B)) < 0 )THEN
            Rr = SQRT(DOT_PRODUCT(px,px))
        ELSEIF( DOT_PRODUCT((px-A),(px-B)) >= 0 )THEN
            Rr = SQRT(DOT_PRODUCT(par(:,i),par(:,i)))
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
            par(:,i) = (Rs + Rd - Rr)*dr
        ELSEIF( Rr > Rd )THEN

        !Reset particles to some random place at the boundary if they exceed the
        !simulation domain to have zero flux through domain boundary 

            CALL RANDOM_NUMBER(rand)
            theta = 2*pi*rand(2)
            phi   = ACOS(2*rand(3) - 1)
            dr(1) = COS(phi)*SIN(theta)
            dr(2) = SIN(phi)*SIN(theta)
            dr(3) = COS(theta) 
            par(:,i) = (2*Rd - Rr)*dr
        ENDIF
    ENDDO
    !$OMP END DO

END SUBROUTINE maintain_boundary_conditions

END MODULE push
