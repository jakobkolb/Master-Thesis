MODULE init

USE global
USE statistics

IMPLICIT NONE

CONTAINS

SUBROUTINE init_parameters

    USE global

    INTEGER :: in=10, tmp
    REAL(8) :: nparin, ntin, C
    CHARACTER(4)    :: trig, arg

    NAMELIST /PARAMETER/ nparin, D, KT, dt, t0, t1, Rd, Rs, U0, Ua, Ub, Un, nbins

    !Read simulation parameters from file

    OPEN(unit=in, file='Parameters.in')
    READ(in,PARAMETER)
    CLOSE(in)

    npar = INT(nparin)

    !readin of terminal arguments and change simulation parameters

    CALL GETARG(2, arg)
    CALL GETARG(1, trig)

    read( arg, '(i10)') tmp

    IF(trig .EQ. 't0') t0 = REAL(tmp)
    IF(trig .EQ. 't1') t1 = REAL(tmp)
    IF(trig .EQ. 'D' ) D  = REAL(tmp)/1000.

    C = npar/(1/3.*Rd**3 - Rs/2.*Rd**2 - 1/3.*Rs**3 + Rs/2.*Rs**2)

    IF(trig .EQ. 'Rs') THEN
        npar = INT(C*(1/3.*Rd**3 - REAL(tmp)/2.*Rd**2 - 1/3.*REAL(tmp)**3 + REAL(tmp)/2.*REAL(tmp)**2))
        Rs = REAL(tmp)
    ELSEIF(trig .EQ. 'Rd') THEN
        npar = INT(C*(1/3.*REAL(tmp)**3 - Rs/2.*REAL(tmp)**2 - 1/3.*Rs**3 + Rs/2.*Rs**2))
        Rd = REAL(tmp)
    ENDIF

    IF(trig .EQ. 'U0') U0 = REAL(tmp)
    IF(trig .EQ. 'Ua') Ua = REAL(tmp)
    IF(trig .EQ. 'Ub') Ub = REAL(tmp)
    IF(trig .EQ. 'Un') Un = REAL(tmp)
 
    print*, 'npar = ', npar
    print*, 'D  = ', D
    print*, 'KT = ', KT
    print*, 'dt = ', dt
    print*, 't0 = ', t0
    print*, 't1 = ', t1
    print*, 'Rd = ', Rd
    print*, 'Rs = ', Rs
    print*, 'U0 = ', U0
    print*, 'Ua = ', Ua
    print*, 'Ub = ', Ub
    print*, 'Un = ', Un
    print*, 'it = ', INT(t1/dt)

    msqd= 0
    md  = 0

END SUBROUTINE init_parameters

SUBROUTINE init_particles

    REAL(8), DIMENSION(3)       :: rand
    REAL(8)                     :: Rr, theta, phi
    INTEGER                     :: i, j, n
    REAL(8), DIMENSION(nbins)   :: Cumm, r

    !Allocate particle array

    ALLOCATE(par(1:3,1:npar))
    ALLOCATE(parold(1:3,1:npar))

    !Initialize Particle Possitions - use inverse sampling to mime the original
    !debye solution for the density profile

    DO i = 1,nbins
        r(i) = Rs + (Rd-Rs)*(REAL(i-1)/(nbins-1))
        Cumm(i) =   (1/3.0*r(i)**3-Rs/2.0*r(i)**2-1/3.0*Rs**3+Rs/2.0*Rs**2)
    ENDDO
    Cumm = Cumm/Cumm(nbins)
    
    write(*,*) Cumm
    write(*,*) '##########################################################'
    write(*,*) r
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
        par(1,i) = Rr*COS(phi)*SIN(theta)
        par(2,i) = Rr*SIN(phi)*SIN(theta)
        par(3,i) = Rr*COS(theta) 
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

