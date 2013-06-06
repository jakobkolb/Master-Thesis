MODULE init

    USE global

    IMPLICIT NONE

    CONTAINS

    SUBROUTINE init_particles

        REAL(8), DIMENSION(3)   :: rand, r
        REAL(8), DIMENSION(4)   :: randbm
        REAL(8)                 :: d, dmin
        INTEGER                 :: i, j, col,  npar=1

        WRITE(*,*) '->init_particles'
!----------------------------------------------------------
!initialize particle possitions making shure they dont over
!lap
        ALLOCATE(par(1:props,1:npar_global))
        j=1 
        DO i=1,par_species
            par(PS,j:j+INT(Parameters(pnumber,i))-1) = i    !define particle species
            j = j+INT(Parameters(pnumber,i))
        ENDDO
        DO 
            CALL RANDOM_NUMBER(rand)
            par(2:4,npar) = L*rand              !insert particle at random location in box
            col = 0
            IF(npar /= 1) THEN
            DO j=1,npar-1                       !check for collisions with previously inserted particles
                r = par(CX:CZ,npar)-par(2:4,j)
                d = SQRT(DOT_PRODUCT(r,r))
                dmin = Parameters(Radius,INT(par(PS,j))) + Parameters(Radius,INT(par(PS,npar)))
                IF(d .LE. dmin) THEN
                    col = col + 1
                ENDIF
            ENDDO
            ENDIF
            IF(col == 0) npar = npar+1          !accept or reject position of new particle
            IF(col /= 0) print*, 'collision'
            IF(npar == npar_global) EXIT        !stopp if total particle count is reached
        ENDDO
!----------------------------------------------------------
!initialize particle velocities according to Boltzmann dist
!using Box Muller transform for Gaussian random numbers
        DO i=1,npar_global
            CALL RANDOM_NUMBER(randbm)
            rand(1) = SQRT(-2*LOG(randbm(1)))*COS(2*pi*randbm(2))
            rand(2) = SQRT(-2*LOG(randbm(1)))*SIN(2*pi*randbm(2))
            rand(3) = SQRT(-2*LOG(randbm(3)))*COS(2*pi*randbm(4))
            par(VX:VZ,i)=0.5*kt*rand
        ENDDO
    END SUBROUTINE init_particles

END MODULE init
