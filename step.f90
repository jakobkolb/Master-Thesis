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
    SUBROUTINE calc_force(par0, force0, forceij)

        REAL(8), DIMENSION(:,:), INTENT(in)  :: par0
        REAL(8), DIMENSION(:,:), INTENT(out) :: force0
        REAL(8), DIMENSION(3)                :: df

        INTEGER         :: i, j
        IF(dl == 1) WRITE(*,*) 'calc_interactions'

        force0 = 0
        DO i=1,npar_global
            DO j=1,iip_length
                IF(i .NE. j) THEN
                CALL forceij(par0(1:props,i),par0(1:props,iip(i,j)),df)
                force0(1:3,i) = force0(1:3,i) + df
                ENDIF
            ENDDO
        ENDDO

    END SUBROUTINE calc_force

    SUBROUTINE LJ(pi, pj, forceij)

        REAL(8), DIMENSION(props) :: pi, pj
        REAL(8), DIMENSION(3)   :: forceij, r
        REAL(8)                 :: d, ds, epsij, sigmaij
        
        sigmaij = Parameters(Radius,INT(pi(PS))) + Parameters(Radius,INT(pj(PS)))
        epsij = eps(INT(pi(PS)),INT(pj(PS)))

        r = MODULO(pi(CX:CZ)-pj(CX:CZ),L)
        ds = sigmaij/SQRT(DOT_PRODUCT(r,r))

        forceij = r*4*epsij/sigmaij/sigmaij*(12*ds**14-6*ds**8)

    END SUBROUTINE LJ

    SUBROUTINE DLVO(pi, pj, forceij)

        REAL(8), DIMENSION(props) :: pi, pj
        REAL(8), DIMENSION(3)     :: forceij, r
        REAL(8)                   :: d, a, kappa, lambda, C, sigmaij

        lambda  = 1/kt                                          !Debye lengt
        kappa   = 1*SQRT(lambda)                                !Bjerrum length
        a       = (Parameters(Radius,INT(pi(PS))) & 
                + Parameters(Radius,INT(pj(PS))))/2             !mean radius of particles i, j
        C = lambda*(exp(kappa*a)/(1+kappa*a))**2    !prefactor for DLVO force after & 
                                                                !http://en.wikipedia.org/wiki/DLVO_theory
        r = MODULO(pi(CX:CZ)-pj(CX:CZ),L)
        d = SQRT(DOT_PRODUCT(r,r))

        forceij = C*(exp(-kappa*d)/d)*(kappa + 1/d)*(r/d)

    END SUBROUTINE DLVO

    SUBROUTINE IDEAL(pi, pj, forceij)

    REAL(8), DIMENSION(props)   :: pi, pj
    REAL(8), DIMENSION(3)       :: forceij

    forceij = 0

    END SUBROUTINE IDEAL

!----------------------------------------------------------
!check for collisions and absorption in sink (nanoparticle)

    SUBROUTINE check_collisions

        IF(dl == 1) WRITE(*,*) 'check_collisions'

    END SUBROUTINE check_collisions

!----------------------------------------------------------
!Integrator for eqm (Runge Kuta 4. Order)

    SUBROUTINE move_particles


        REAL(8), DIMENSION(props,npar_global)   :: y, f1, f2, f3, f4
        REAL(8), DIMENSION(3,npar_global)       :: dx
        REAL(8), DIMENSION(3)                   :: rand
        REAL(8), DIMENSION(4)                   :: randbm
        REAL(8), DIMENSION(par_species)         :: DS
        INTEGER                                 :: i

        IF(dl == 1) WRITE(*,*) 'move_particles'

        f1 = 0
        f2 = 0
        f3 = 0
        f4 = 0

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

        DS = sqrt(2*Parameters(D,1:par_species))
        par(VX:VZ,:) = 0
        DO i = 1,npar_global
            CALL RANDOM_NUMBER(randbm)
            rand(1) = SQRT(-2*LOG(randbm(1)))*COS(2*pi*randbm(2))
            rand(2) = SQRT(-2*LOG(randbm(1)))*SIN(2*pi*randbm(2))
            rand(3) = SQRT(-2*LOG(randbm(3)))*COS(2*pi*randbm(4))
            par(CX:CZ,i) = par(CX:CZ,i) + DS(INT(par(PS,i)))*rand*dt
            par(VX:VZ,i) = DS(INT(par(PS,i)))*rand
        ENDDO

        par(VX:VZ,1:npar_global) =  par(VX:VZ,1:npar_global) &
                                    + (f1(CX:CZ,:) + 2.0*(f2(CX:CZ,:) + f3(CX:CZ,:)) + f4(CX:CZ,:))/6.0
        t = t + dt

    END SUBROUTINE move_particles
!----------------------------------------------------------
!Subroutine to calculate koefficients for RK integrator
    SUBROUTINE eqm(t0,par0,f)

        REAL(8), DIMENSION(:,:), INTENT(in) :: par0
        REAL(8), DIMENSION(:,:), INTENT(inout) :: f

        REAL(8), DIMENSION(1:3,1:npar_global)             :: force0 
        REAL(8), INTENT(in) :: t0
        INTEGER :: i,j

        CALL calc_force(par0, force0, IDEAL)

        DO i=1,npar_global
        f(CX:CZ,i) = force0(1:3,i)*kt*Parameters(D,INT(par(PS,i)))
        f(VX:VZ,i) = 0
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
