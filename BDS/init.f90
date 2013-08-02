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
    INTEGER                 :: i, j, n=1

    WRITE(*,*) '->init_particles'

    sink_poss = L/2

    DO 
        CALL RANDOM_NUMBER(rand)
        par(:,n) = L*rand              !insert particle at random location in box
            r = sink_poss - par(:,n)
            dr = SQRT(DOT_PRODUCT(r,r))
            IF(dr > sink_radius*L) THEN
                n = n + 1
            ENDIF
        IF(n == npar) EXIT        !stopp if total particle count is reached
    ENDDO

END SUBROUTINE init_particles

SUBROUTINE init_statistics(bins)

    INTEGER, INTENT(in) :: bins

    CALL clear5(bins+1,500)

END SUBROUTINE init_statistics

SUBROUTINE open_output_files

    dens_final = 20
    rate_final = 21

    OPEN(unit=dens_final, file="dens_profile.out", action="write")
    OPEN(unit=rate_final, file="rate_data.out", action="write")


END SUBROUTINE open_output_files

SUBROUTINE close_output_files

    CLOSE(dens_final)
    CLOSE(rate_final)

END SUBROUTINE close_output_files

END MODULE init

