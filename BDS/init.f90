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

    NAMELIST /PARAMETER/ nparin, D, KT, dt, ntin, L, sink_radius, thickness, nbins, gap, U1, U0, t0, t1

    OPEN(unit=in, file='Parameters.in')
    READ(in,PARAMETER)
    CLOSE(in)

    npar = INT(nparin)
    nt   = INT(ntin)

    !readin of terminal arguments

    CALL GETARG(2, arg)
    CALL GETARG(1, trig)

    read( arg, '(i10)') tmp

    IF(trig .EQ. 'Ra') sink_radius = tmp
    IF(trig .EQ. 't0') t0 = tmp/10.0
    IF(trig .EQ. 't1') t1 = tmp/10.0
 
    !rescalling of time parameters

    dt   = dt/sink_radius**2/D
    t0   = t0/sink_radius**2/D
    t1   = t1/sink_radius**2/D
  
    print*, 'Ra = ', sink_radius
    print*, 't0 = ', t0
    print*, 't1 = ', t1
    print*, 'dt = ', dt

END SUBROUTINE init_parameters

SUBROUTINE init_particles

    REAL(8), DIMENSION(3)       :: rand, sink_poss
    REAL(8), DIMENSION(4)       :: randbm
    REAL(8)                     :: Rr, Rs, theta, phi
    INTEGER                     :: i, j, n
    REAL(8), DIMENSION(nbins)   :: Cumm, r

    WRITE(*,*) '->init_particles'

    !Allocate particle array

    ALLOCATE(par(1:3,1:npar))
    ALLOCATE(parold(1:3,1:npar))

    !Initialize Particle Possitions - use inverse sampling to mime the original
    !debye solution for the density profile

    Rs = L/2.0
    par(:,:) = Rs

    DO i = 1,nbins
        r(i) = sink_radius + (Rs-sink_radius)*(REAL(i)/nbins)
        Cumm(i) =   (1/3.0*r(i)**3-1/2.0*r(i)**2-1/3.0*sink_radius**3+1/2.0*sink_radius**2)/ &
                    (1/3.0*Rs**3-1/2.0*Rs**2-1/3.0*sink_radius**3+1/2.0*sink_radius**2)
    ENDDO
    DO i = 1,npar
        CALL RANDOM_NUMBER(rand)
        DO j = 1,nbins
            IF(rand(1) .LE. Cumm(j)) THEN
                Rr = r(j)
                EXIT
            ENDIF
        ENDDO
        theta = 2*pi*rand(2)
        phi   = ACOS(2*rand(3) - 1)
        par(1,i) = par(1,i) + Rr*COS(phi)*SIN(theta)
        par(2,i) = par(2,i) + Rr*SIN(phi)*SIN(theta)
        par(3,i) = par(3,i) + Rr*COS(theta) 
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

