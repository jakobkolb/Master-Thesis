MODULE push

USE global

IMPLICIT NONE

CONTAINS

SUBROUTINE move_particles

    REAL(8), DIMENSION(3,npar)  :: erand
    REAL(8), DIMENSION(3,npar)  :: nrand1, nrand2
    REAL(8), DIMENSION(3,npar)  :: f_eff
    REAL(8)                     :: Dprime, r
    INTEGER                     :: i, j

    CALL RANDOM_NUMBER(nrand1)
    CALL RANDOM_NUMBER(nrand2)

    !$OMP PARALLEL DO
    DO i = 1,npar
        DO j = 1,3
            erand(j,i) = SQRT(-2*LOG(nrand1(j,i)))*COS(2*pi*nrand2(j,i))
        ENDDO
    ENDDO
    !$OMP END PARALLEL DO

    f_eff = 0

!    !$OMP PARALLEL DO
!CALCULATE INTERACTION FORCES HERE
!    !$OMP END PARALLEL DO

    Dprime = SQRT(2*D*dt)

    !$OMP PARALLEL DO
    DO i = 1,npar
        DO j = 1,3
            par(j,i) = par(j,i) +f_eff(j,i) + Dprime*erand(j,i)
        ENDDO
    ENDDO
    !$OMP END PARALLEL DO

    CALL make_periodic

END SUBROUTINE move_particles

SUBROUTINE make_periodic

    INTEGER :: i, j
    
    !$OMP PARALLEL DO
    DO i = 1,npar
        DO j = 1,3
            par(j,i) = MODULO(par(j,i),L)
        ENDDO
    ENDDO
    !$OMP END PARALLEL DO

END SUBROUTINE make_periodic

SUBROUTINE sink(counter)

    REAL(8)                 :: Rr   !minimum distance of Particle to sink
    REAL(8), DIMENSION(3)   :: r    !particle vector relative to sink
    REAL(8), DIMENSION(3)   :: Rs   !Position of the sink
    REAL(8), DIMENSION(3)   :: rd   !random displacement vector
    REAL(8), DIMENSION(4)   :: rand
    INTEGER, INTENT(out)    :: counter !counter for absorbed particles
    INTEGER                 :: i, j

    Rs = L/2.

    counter = 0

   !$OMP DO REDUCTION(+:counter) PRIVATE(Rr, rand, rd, r)
    DO i = 1,npar
        r  = Rs - par(:,i)
        Rr = SQRT(DOT_PRODUCT(r,r))
        IF( Rr < sink_radius )THEN
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
