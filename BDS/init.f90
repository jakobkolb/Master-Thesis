MODULE init

USE global

IMPLICIT NONE

CONTAINS

SUBROUTINE init_parameters

    USE global

    INTEGER :: in=10

    NAMELIST /PARAMETER/ npar, D, KT, dt, nt, L, sink_radius, thickness, nbins, gap, U1, U0

    OPEN(unit=in, file='Parameters.in')
    READ(in,PARAMETER)
    CLOSE(in)

END SUBROUTINE init_parameters

SUBROUTINE init_particles

    USE global

    IMPLICIT NONE

    REAL(8), DIMENSION(3)   :: rand, r, sink_poss
    REAL(8), DIMENSION(4)   :: randbm
    REAL(8)                 :: Rr
    INTEGER                 :: i, j, n

    WRITE(*,*) '->init_particles'

    !Allocate particle array

    ALLOCATE(par(1:3,1:npar))
    ALLOCATE(parold(1:3,1:npar))

    ALLOCATE(dr(1:3,1:npar))

    dr = 0

    !Initialize Particle Possitions

    sink_poss = L/2
    n = 1
    DO
        CALL RANDOM_NUMBER(rand)
        par(:,n) = L*rand              !insert particle at random location in box
            r = sink_poss - par(:,n)
            Rr = SQRT(DOT_PRODUCT(r,r))
            IF(Rr > sink_radius*L) THEN
                n = n + 1
            ENDIF
        IF(n == npar) EXIT        !stopp if total particle count is reached
    ENDDO
END SUBROUTINE init_particles

SUBROUTINE init_statistics(bins)

    INTEGER, INTENT(in) :: bins

    CALL clear5(bins+2,500)

END SUBROUTINE init_statistics

SUBROUTINE open_output_files

    dens_final = 20
    rate_final = 21

    OPEN(unit=dens_final, file="dens_data.out", action="write")
    OPEN(unit=rate_final, file="rate_data.out", action="write")


END SUBROUTINE open_output_files

SUBROUTINE close_output_files

    CLOSE(dens_final)
    CLOSE(rate_final)

END SUBROUTINE close_output_files

END MODULE init

