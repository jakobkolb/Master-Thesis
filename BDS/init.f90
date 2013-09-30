MODULE init

USE global

IMPLICIT NONE

CONTAINS

SUBROUTINE init_parameters

    USE global

    INTEGER :: in=10

    NAMELIST /PARAMETER/ npar, D, KT, dt, nt, L, nbins, gap, U1, U0, sink_radius, thickness

    OPEN(unit=in, file='Parameters.in')
    READ(in,PARAMETER)
    CLOSE(in)

END SUBROUTINE init_parameters

SUBROUTINE init_particles

    USE global

    IMPLICIT NONE

    REAL(8), DIMENSION(3)   :: rand, sink_poss
    REAL(8), DIMENSION(1001):: CDF
    REAL(8), DIMENSION(3)   :: rnd
    REAL(8)                 :: r, theta, phi
    INTEGER                 :: i, j, n

    WRITE(*,*) '->init_particles'

    !Allocate particle array

    ALLOCATE(par(1:3,1:npar))
    ALLOCATE(parold(1:3,1:npar))

    !Initialize Particle Possitions

    sink_poss = L/2
    n = 1

    DO i = 1,1001
        r = i*L/2*(1-sink_radius)/1000 + L/2*sink_radius
        CDF(i) = r**3/3 - L*sink_radius*r**2 + (L*sink_radius)**3/6
    ENDDO

    CDF = CDF/CDF(1000)

    DO i = 1,npar

        CALL RANDOM_NUMBER(rnd)
        j = 0
        DO
            j = j + 1
            IF(rnd(1) < CDF(j)) EXIT
        ENDDO
        r       = j*L/2*(1-sink_radius)/1000 + L/2*sink_radius
        theta   = 1*pi*rnd(2)
        phi     = ACOS(2*rnd(3) - 1)

        par(1,i) = r*SIN(theta)*COS(phi) + L/2
        par(2,i) = r*SIN(theta)*SIN(phi) + L/2
        par(3,i) = r*COS(theta) + L/2
    ENDDO
END SUBROUTINE init_particles

SUBROUTINE init_statistics(bins)

    INTEGER, INTENT(in) :: bins

    CALL clear5(bins+1,500)

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

