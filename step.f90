MODULE step

    USE global

    IMPLICIT NONE

    CONTAINS

!==========================================================
!Routines to solve Brownian equations of Motion 


!----------------------------------------------------------
!Calculate force vektor for particles 
!cal_interactions sums up all interactions between interacting
!particles for each particle in the box
!force12 calculates force between particle i and particle j
    SUBROUTINE calc_interactions(par0, force0)

        REAL(8), DIMENSION(:,:), INTENT(in) :: par0
        REAL(8), DIMENSION(:,:), INTENT(out) :: force0

        INTEGER         :: i, j
        WRITE(*,*) 'calc_interactions'

        force0 = 0
        DO i=1,npar_global
            DO j=1,iip_length
                force0(1:3,i) = force0(1:3,i)+forceij(par0(1:props,i),par0(1:props,iip(i,j)))
            ENDDO
        ENDDO

    END SUBROUTINE calc_interactions

    FUNCTION forceij(pi, pj)

        REAL(8), DIMENSION(props) :: pi, pj
        REAL(8), DIMENSION(3)   :: forceij, r
        REAL(8)                 :: d, ds, epsij, sigmaij
        
        sigmaij = sigma(INT(pi(PS)),INT(pj(PS)))
        epsij = eps(INT(pi(PS)),INT(pj(PS)))
        r = pi(2:4)-pj(2:4)
        ds = sigmaij/SQRT(DOT_PRODUCT(r,r))

        forceij = r*4*epsij/sigmaij/sigmaij*(12*ds**14-6*ds**8)

    END FUNCTION forceij

!----------------------------------------------------------
!check for collisions and absorption in sink (nanoparticle)

    SUBROUTINE check_collisions

        WRITE(*,*) 'check_collisions'

    END SUBROUTINE check_collisions

!----------------------------------------------------------
!Integrator for eqm (RK?)

    SUBROUTINE move_particles


        REAL(8), DIMENSION(props,npar_global) :: y, f1, f2, f3, f4

        WRITE(*,*) 'move_particles'

        CALL eqm(t,par,f1)
        y(:,:) = par(:,:) + 0.5*dt*f1(:,:)
        CALL make_periodic(y)
        CALL eqm(t + 0.5*dt, y, f2)
        y(:,:) = par(:,:) + 0.5*dt*f2(:,:)
        CALL make_periodic(y)
        CALL eqm(t + 0.5*dt, y, f3)
        y(:,:) = par(:,:) + dt*f3
        CALL make_periodic(y)
        CALL eqm(t + dt, y, f4)
        par(:,:) = par(:,:) + dt*(f1(:,:) + 2.0*(f2(:,:) + f3(:,:)) + f4(:,:))/6.0
        CALL make_periodic(par)

        t = t + dt

    END SUBROUTINE move_particles

    SUBROUTINE eqm(t0,par0,f)

        REAL(8), DIMENSION(:,:), INTENT(in) :: par0
        REAL(8), DIMENSION(:,:), INTENT(inout) :: f

        REAL(8), DIMENSION(1:3,1:npar_global)             :: force0 
        REAL(8), INTENT(in) :: t0
        INTEGER :: i,j

        CALL calc_interactions(par0, force0)
        
        f = 0

        DO i=1,npar_global
        f(CX:CZ,i) = par0(VX:VZ,i)
        f(VX:VZ,i) = force0(1:3,i)
        ENDDO
        
    END SUBROUTINE eqm

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
