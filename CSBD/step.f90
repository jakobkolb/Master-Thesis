MODULE step

    USE global

    IMPLICIT NONE

    CONTAINS

!==========================================================
!Routines to solve Brownian equations of Motion 


!----------------------------------------------------------
!Calculate force vektor for particles 
!calc_force sums up all interactions between interacting
!particles for each particle in the box
!force12 calculates force between particle i and particle j
    SUBROUTINE calc_force(par0, force0)

        REAL(8), DIMENSION(:,:), INTENT(in)  :: par0
        REAL(8), DIMENSION(:,:), INTENT(out) :: force0
        REAL(8), DIMENSION(3)                :: df

        INTEGER         :: i, j
        IF(dl == 1) WRITE(*,*) 'calc_interactions'

        force0 = 0

    END SUBROUTINE calc_force

!----------------------------------------------------------
!check for collisions and absorption in sink (nanoparticle)

        SUBROUTINE rij(pi, pj, dp)

            REAL(8), DIMENSION(3), INTENT(in)   :: pi, pj
            REAL(8), DIMENSION(3), INTENT(out)  :: dp
            INTEGER                             :: i

            DO i = 1,3
                dp(i) = pj(i) - pi(i)
                IF(abs(dp(i)) > L*0.5) dp(i) = dp(i) - sign(L,dp(i))
            ENDDO

        END SUBROUTINE rij

!----------------------------------------------------------
!Integrator for eqm trivial gauss

        SUBROUTINE move_particles


            REAL(8), DIMENSION(3,npar_global)       :: dx
            REAL(8), DIMENSION(3)                   :: rand
            REAL(8), DIMENSION(4*npar_global)       :: randbm
            REAL(8), DIMENSION(par_species)         :: DS
            INTEGER                                 :: i
            REAL(8), DIMENSION(3,npar_global)       :: force0

            IF(dl == 1) WRITE(*,*) 'move_particles'

            CALL calc_force(par(CX:CZ,:),force0)

            DS = sqrt(2*Parameters(D,1:par_species))
            par(VX:VZ,:) = par(CX:CZ,:)
            CALL RANDOM_NUMBER(randbm)

            DO i = 1,npar_global
                rand(1) = SQRT(-2*LOG(randbm(4*(i-1)+1)))*COS(2*pi*randbm(4*(i-1)+2))
                rand(2) = SQRT(-2*LOG(randbm(4*(i-1)+1)))*SIN(2*pi*randbm(4*(i-1)+2))
                rand(3) = SQRT(-2*LOG(randbm(4*(i-1)+3)))*COS(2*pi*randbm(4*(i-1)+4))
                par(CX:CZ,i) = par(CX:CZ,i) + Parameters(D,INT(par(PS,i)))*force0(1:3,i)*dt/kt + DS(INT(par(PS,i)))*rand*dt
            ENDDO

            par(VX:VZ,:) = (par(CX:CZ,:) - par(VX:VZ,:))/dt
            CALL make_periodic(par)

            t = t + dt

        END SUBROUTINE move_particles
!----------------------------------------------------------
!make particle positions periodic

    SUBROUTINE make_periodic(pp)

        REAL(8), DIMENSION(:,:), INTENT(inout) :: pp
        INTEGER :: i, j

        DO i=1,npar_global
            DO j=CX,CZ
               pp(j,i) = MODULO(pp(j,i),L)
            ENDDO
        ENDDO

    END SUBROUTINE make_periodic

END MODULE step
