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

SUBROUTINE sink(diameter,thickness,counter)

    REAL(8), INTENT(in)     :: diameter    !Diameter of the sink as fraction of L
    REAL(8), INTENT(in)     :: thickness   !Thickness of layer for particle displacement as fraction of L
    REAL(8)                 :: Rr   !Distance of Particle to sink
    REAL(8), DIMENSION(3)   :: R    !Position of the sink
    REAL(8), DIMENSION(3)   :: rd   !random displacement vector
    REAL(8), DIMENSION(4)   :: rand
    INTEGER, INTENT(out)    :: counter !counter for absorbed particles
    INTEGER                 :: i, j

    R = L/2.

    counter = 0

    !$OMP DO REDUCTION(+:counter) PRIVATE(Rr, rand, rd)
    DO i = 1,npar
        Rr = SQRT(DOT_PRODUCT(par(:,i)-R,par(:,i)-R))
        IF(Rr < diameter*L) THEN
            counter = counter + 1
            CALL RANDOM_NUMBER(rand)
            rd(1) = (L/2. - thickness*rand(1))*COS(2*pi*rand(2))*SIN(pi*rand(3))
            rd(2) = (L/2. - thickness*rand(1))*SIN(2*pi*rand(2))*SIN(pi*rand(3))
            rd(3) = (L/2. - thickness*rand(1))*COS(pi*rand(3))
            par(:,i) = R + rd
        ENDIF
    ENDDO
    !$OMP END DO

END SUBROUTINE sink

END MODULE push
