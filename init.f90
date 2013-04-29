MODULE init

    USE global

    IMPLICIT NONE

    CONTAINS

    SUBROUTINE init_particles

        REAL(8), DIMENSION(3)   :: rand, r
        REAL(8)                 :: d
        INTEGER                 :: i, j, col,  npar=1

        WRITE(*,*) '->init_particles'

        ALLOCATE(par(1:props,1:npar_global))
                
            CALL RANDOM_NUMBER(rand)
            par(2:4,npar) = L*rand
            npar = npar+1
        DO 
            CALL RANDOM_NUMBER(rand)
            par(2:4,npar) = L*rand              !insert particle at random location in box
            col = 0
            DO j=1,npar-1                       !check for collisions with previously inserted particles
                r = par(2:4,npar)-par(2:4,j)
                d = SQRT(DOT_PRODUCT(r,r))
                IF(d .LE. (sigma(INT(par(1,j)))+sigma(INT(par(1,npar))))) col = col + 1
            ENDDO
            IF(col == 0) npar = npar+1          !accept or reject position of new particle
            IF(npar == npar_global) RETURN      !stopp if total particle count is reached
        ENDDO
                
            

    END SUBROUTINE init_particles

END MODULE init
