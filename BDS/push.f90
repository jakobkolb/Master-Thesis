MODULE push

USE global

IMPLICIT NONE

CONTAINS

SUBROUTINE move_particles

    REAL(8), DIMENSION(3,npar)  :: erand
    REAL(8), DIMENSION(3,npar)  :: nrand1, nrand2
    REAL(8), DIMENSION(3,npar)  :: f_eff
    REAL(8)                     :: Dprime, r
    INTEGER                     :: i

    CALL RANDOM_NUMBER(nrand1)
    CALL RANDOM_NUMBER(nrand2)

    !$OMP PARALLEL DO
    DO i = 1,npar
        erand(:,i) = SQRT(-2*LOG(nrand1(:,i)))*COS(2*pi*nrand2(:,i))
    ENDDO
    !$OMP END PARALLEL DO

    f_eff = 0

!    !$OMP PARALLEL DO
!    DO i = 1,npar
!        r = SQRT(DOT_PRODUCT(par(:,i) - L/2, par(:,i) - L/2))
!        IF(r > sink_radius*L + gap .AND. r < sink_radius*L + 2*U1*L + gap) THEN
!            f_eff(:,i) = -U0*2*(r-sink_radius*L-U1*L)*(par(:,i)-L/2)/r
!        ENDIF
!    ENDDO
!   !$OMP END PARALLEL DO

    Dprime = SQRT(2*D*dt)

    !$OMP PARALLEL DO
    DO i = 1,npar
        dr(:,i) = f_eff(:,i) + Dprime*erand(:,i)
    ENDDO
    !$OMP END PARALLEL DO

    par = par + dr

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

    REAL(8)                 :: Rr12, Rr1, Rr2   !minimum distance of Particle to sink &
                                                !either start or end point or point in between
    REAL(8), DIMENSION(3)   :: r12  !particle trajectory
    REAL(8), DIMENSION(3)   :: r1   !particle start vector, relative to sink
    REAL(8), DIMENSION(3)   :: r2   !particle end vector, realtive to sink
    REAL(8), DIMENSION(3)   :: r1xr12!cross product of r1 and r12 
    REAL(8), DIMENSION(3)   :: R    !Position of the sink
    REAL(8), DIMENSION(3)   :: rd   !random displacement vector
    REAL(8), DIMENSION(4)   :: rand
    INTEGER, INTENT(out)    :: counter !counter for absorbed particles
    INTEGER                 :: i, j

    R = L/2.

    counter = 0

   !$OMP DO REDUCTION(+:counter) PRIVATE(Rr1, Rr2, Rr12, rand, rd, r1, r2, r12, r1xr12)
    DO i = 1,npar
        r1  = R - parold(:,i)
        r2  = R - par(:,i)
        r12 = dr(:,i)/SQRT(DOT_PRODUCT(dr(:,i),dr(:,i)))
        r1xr12(1) = r1(2)*r12(3) - r1(3)*r12(2)
        r1xr12(2) = r1(3)*r12(1) - r1(1)*r12(3)
        r1xr12(3) = r1(1)*r12(2) - r1(2)*r12(1)
        Rr12  = SQRT(DOT_PRODUCT(r1xr12,r1xr12))
        Rr1 = SQRT(DOT_PRODUCT(r1,r1))
        Rr2 = SQRT(DOT_PRODUCT(r2,r2))
        IF( Rr2 < sink_radius*L &
            .OR. (Rr12  < sink_radius*L .AND. &
            DOT_PRODUCT(dr(:,i),r1)/SQRT(DOT_PRODUCT(r1,r1))*DOT_PRODUCT(dr(:,i),r2)/SQRT(DOT_PRODUCT(r2,r2)) < 0 .AND. &
            SQRT(DOT_PRODUCT(r1,r1)) - SQRT(DOT_PRODUCT(dr(:,i),dr(:,i))) < sink_radius*L ) &
            )THEN
            counter = counter + 1
!           IF(Rr12  < sink_radius*L .AND. &
!           DOT_PRODUCT(dr(:,i),r1)/SQRT(DOT_PRODUCT(r1,r1))*DOT_PRODUCT(dr(:,i),r2)/SQRT(DOT_PRODUCT(r2,r2)) < 0) THEN
!               print*, '-------------------------------------------------------------'
!               print*, parold(:,i) - R
!               print*, par(:,i) - R
!               print*, DOT_PRODUCT(dr(:,i),r1)/SQRT(DOT_PRODUCT(r1,r1))
!               print*, DOT_PRODUCT(dr(:,i),r2)/SQRT(DOT_PRODUCT(r2,r2))
!               print*, L*sink_radius, Rr12, Rr2
!           ENDIF

            CALL RANDOM_NUMBER(rand)
            rd(1) = (L/2. - thickness*rand(1))*COS(2*pi*rand(2))*SIN(pi*rand(3))
            rd(2) = (L/2. - thickness*rand(1))*SIN(2*pi*rand(2))*SIN(pi*rand(3))
            rd(3) = (L/2. - thickness*rand(1))*COS(pi*rand(3))
            par(:,i) = R + rd
        ENDIF
    ENDDO
    !$OMP END DO

    CALL make_periodic

END SUBROUTINE sink

END MODULE push
