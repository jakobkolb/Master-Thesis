MODULE init

USE global
USE statistics

IMPLICIT NONE

CONTAINS

SUBROUTINE init_parameters

    USE global

    INTEGER :: in=10, tmp
    REAL(8) :: nparin, ntin, C, decay_length
    CHARACTER(4)    :: trig, arg

    NAMELIST /PARAMETER/    nparin, D, KT, dt, t0, t1, Rd, U0,&
                            U1, l, g, Un, decay_length, fmode, nbins,&
                            potential_shape

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

    IF(trig .EQ. 'U0' ) U0  = REAL(tmp)/10.0
    IF(trig .EQ. 'U1' ) U1  = REAL(tmp)/10.0
    IF(trig .EQ. 'l' ) l  = REAL(tmp)/10.0
    IF(trig .EQ. 'g' ) g  = REAL(tmp)/10.0
    IF(trig .EQ. 'Un' ) Un  = REAL(tmp)/10.0

    IF(trig .EQ. 'rd') decay_length = 10**(REAL(tmp)-6)

    K01 = decay_length**2*D*0.5
    K10 = K01

    print*, 'npar = ', npar
    print*, 'D  = ', D
    print*, 'KT = ', KT
    print*, 'dt = ', dt
    print*, 't0 = ', t0
    print*, 't1 = ', t1
    print*, 'Rd = ', Rd
    print*, 'Rs = ', Rs
    print*, 'U0 = ', U0
    print*, 'U1 = ', U1
    print*, 'l = ', l
    print*, 'g = ', g
    print*, 'Un = ', Un
    print*, 'K01= ', K01
    print*, 'K10= ', K10
    print*, 'it = ', INT(t1/dt)

    msqd= 0
    md  = 0

END SUBROUTINE init_parameters

SUBROUTINE init_particles

    REAL(8), DIMENSION(3)       :: rand
    REAL(8)                     :: Rr, dr, theta, phi, a1, a2, a3, fracU0, fracU1, randU, Ua, Ub
    INTEGER                     :: i, j, n
    REAL(8), DIMENSION(nbins)   :: Cumm, r

    !Allocate particle array

    ALLOCATE(par(1:4,1:npar))
    ALLOCATE(parold(1:4,1:npar))

    !use uniform distribution for initial condition. This way transsients can be
    !more ore less quantified.
  
    DO i = 1,npar
        Rr = 0
        DO WHILE((Rr <= Rs) .OR. (Rr >= Rd))
            CALL RANDOM_NUMBER(rand)
            rand = Rd*rand
            Rr = SQRT(DOT_PRODUCT(rand,rand))
        ENDDO
        IF (Rr .GE. Rs) THEN
            print*, Rr
        ENDIF
        par(1,i) = rand(1)
        par(2,i) = rand(2)
        par(3,i) = rand(3)
    ENDDO

!Initialize particle state according to detailled equilibrium

    IF(fmode == 0) THEN
        fracU0 = K10/(K10+K01)*npar
        fracU1 = K01/(K10+K01)*npar

        CALL RANDOM_NUMBER(randU)

        IF(randU <= fracU0) THEN
            par(4,:) = 0
        ELSEIF(randU > fracU0) THEN
            par(4,:) = 1
        ENDIF

    ELSEIF(fmode == 1) THEN
        fracU0 = K10/(K10+K01)*npar
        fracU1 = K01/(K10+K01)*npar

        DO i = 1,npar
            IF(i <= fracU0) THEN
                par(4,i) = 0
            ELSEIF(i > fracU0) THEN
                par(4,i) = 1
            ENDIF
        ENDDO
    ENDIF
END SUBROUTINE init_particles

SUBROUTINE init_statistics(bins)

    INTEGER, INTENT(in) :: bins

    CALL clear5(2*bins+1,500)

END SUBROUTINE init_statistics

END MODULE init

