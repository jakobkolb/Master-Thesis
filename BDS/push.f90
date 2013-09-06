MODULE push

USE global

IMPLICIT NONE

CONTAINS

SUBROUTINE move_particles

    REAL(8), DIMENSION(3,npar)  :: erand
    REAL(8), DIMENSION(3,npar)  :: nrand1, nrand2
    REAL(8)                     :: Dprime
    INTEGER                     :: i

    CALL RANDOM_NUMBER(nrand1)
    CALL RANDOM_NUMBER(nrand2)

    !$OMP PARALLEL DO
    DO i = 1,npar
        erand(:,i) = SQRT(-2*LOG(nrand1(:,i)))*COS(2*pi*nrand2(:,i))
    ENDDO
    !$OMP END PARALLEL DO

    Dprime = SQRT(2*D*dt)

    !$OMP PARALLEL DO
    DO i = 1,npar
        par(:,i) = par(:,i) + Dprime*erand(:,i)
    ENDDO
    !$OMP END PARALLEL DO

    CALL make_periodic

END SUBROUTINE move_particles

SUBROUTINE make_periodic

    INTEGER :: i, j
    
    !$OMP PARALLEL DO
    DO i = 1,npar
        par(:,i) = MODULO(par(:,i),L)
    ENDDO
    !$OMP END PARALLEL DO

END SUBROUTINE make_periodic

SUBROUTINE sink(counter)

    REAL(8)                 :: Rr, Rr1   !minimum distance of Particle to sink
    REAL(8), DIMENSION(3)   :: r12  !particle trajectory
    REAL(8), DIMENSION(3)   :: r1   !particle start vector, relative to sink
    REAL(8), DIMENSION(3)   :: r1xr12!cross product of r1 and r12 
    REAL(8), DIMENSION(3)   :: R    !Position of the sink
    REAL(8), DIMENSION(3)   :: rd   !random displacement vector
    REAL(8), DIMENSION(3)   :: rand
    INTEGER, INTENT(out)    :: counter !counter for absorbed particles
    INTEGER                 :: i, j
    REAL(8)                 :: theta, phi !angles for new particle possition

    R = L/2.

    counter = 0

   !$OMP DO REDUCTION(+:counter) PRIVATE(Rr, rand, rd, r1, r12, r1xr12)
    DO i = 1,npar
        r1  = R - parold(:,i)
        r12 = parold(:,i) - par(:,i)
        r1xr12(1) = r1(2)*r12(3) - r1(3)*r12(2)
        r1xr12(2) = r1(3)*r12(1) - r1(1)*r12(3)
        r1xr12(3) = r1(1)*r12(2) - r1(2)*r12(1)
        Rr  = SQRT(DOT_PRODUCT(r1xr12,r1xr12))/SQRT(DOT_PRODUCT(r12,r12))
        Rr1 = SQRT(DOT_PRODUCT(r1,r1))
        IF( Rr < sink_radius*L .AND. &
            Rr1 - ABS(SQRT(DOT_PRODUCT(r12,r12))) < sink_radius*L .AND. &
            SQRT(DOT_PRODUCT(r12,r12)) .LE. SQRT(2*D*dt)) THEN
            counter = counter + 1
        print*, '-------------------------------------------------------------'
        print*, parold(:,i) - R
        print*, par(:,i) - R
        print*, L*sink_radius, Rr, Rr1
            CALL RANDOM_NUMBER(rand)
            theta   = 2*pi*rand(2)
            phi     = ACOS(2*rand(3) - 1)
            rd(1) = (L/2. - thickness*rand(1))*COS(phi)*SIN(theta)
            rd(2) = (L/2. - thickness*rand(1))*SIN(phi)*SIN(theta)
            rd(3) = (L/2. - thickness*rand(1))*COS(theta)
            par(:,i) = R + rd
        ENDIF
    ENDDO
    !$OMP END DO

END SUBROUTINE sink

END MODULE push
