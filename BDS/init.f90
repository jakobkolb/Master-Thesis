MODULE init

USE global
USE statistics

IMPLICIT NONE

CONTAINS

SUBROUTINE init_parameters

    USE global

    INTEGER :: in=10, tmp
    REAL(8) :: nparin, ntin
    CHARACTER(2)    :: trig, arg

    NAMELIST /PARAMETER/ nparin, D, KT, dt, ntin, L, sink_radius, thickness, nbins, gap, U1, U0

    OPEN(unit=in, file='Parameters.in')
    READ(in,PARAMETER)
    CLOSE(in)

    npar = INT(nparin)
    nt   = INT(ntin)
    dt   = dt*sink_radius**2/D

    CALL GETARG(2, arg)
    CALL GETARG(1, trig)

    read( arg, '(i10)') tmp

    print*, 'Ra =', tmp

    IF(trig .EQ. 'Ra') sink_radius = tmp
    

END SUBROUTINE init_parameters

SUBROUTINE init_particles

    REAL(8), DIMENSION(3)   :: rand, r, sink_poss
    REAL(8), DIMENSION(4)   :: randbm
    REAL(8)                 :: Rr
    INTEGER                 :: i, j, n

    WRITE(*,*) '->init_particles'

    !Allocate particle array

    ALLOCATE(par(1:3,1:npar))
    ALLOCATE(parold(1:3,1:npar))

    !Initialize Particle Possitions

    sink_poss = L/2
    n = 1
    DO
        CALL RANDOM_NUMBER(rand)
        par(:,n) = L*rand              !insert particle at random location in box
            r = sink_poss - par(:,n)
            Rr = SQRT(DOT_PRODUCT(r,r))
            IF(Rr > sink_radius .AND. Rr < L/2) THEN
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

    dens_final  = 20
    rate_final  = 21

    OPEN(unit=dens_final, file="dens_data.out", action="write")
    OPEN(unit=rate_final, file="rate_data.out", action="write")


END SUBROUTINE open_output_files

SUBROUTINE close_output_files

    CLOSE(dens_final)
    CLOSE(rate_final)

END SUBROUTINE close_output_files

END MODULE init

