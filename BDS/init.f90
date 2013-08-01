MODULE init

USE global

IMPLICIT NONE

CONTAINS

SUBROUTINE init_particles

    USE global

    IMPLICIT NONE

    REAL(8), DIMENSION(3)   :: rand, r, sink_poss
    REAL(8), DIMENSION(4)   :: randbm
    REAL(8)                 :: dr
    INTEGER                 :: i, j, col, n=1

    WRITE(*,*) '->init_particles'

    sink_poss = L/2

    DO 
        CALL RANDOM_NUMBER(rand)
        par(:,n) = L*rand              !insert particle at random location in box
        col = 0
        DO j=1,npar-1                       !check for collisions with sink
            r = sink_poss - par(:,j)
            dr = SQRT(DOT_PRODUCT(r,r))
            IF(dr > sink_radius) THEN
                n = n + 1
            ENDIF
        ENDDO
        IF(n == npar) EXIT        !stopp if total particle count is reached
    ENDDO

END SUBROUTINE init_particles

END MODULE init

