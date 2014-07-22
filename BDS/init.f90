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
    IF(trig .EQ. 'D' ) D  = REAL(tmp)/1000.

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

    !Initialize Particle Possitions - use inverse sampling to mime the original
    !debye solution for the density profile
    Ub = Rs+(1+g)*l
    Ua = Rs+l
    Cumm = 0
    Rr = Rs
    dr = (Rd-Rs)/(nbins)
    r = 0

    a1 = 1
    a2 = (1-Rs/(Rs+Ua))*exp(-U0/KT) + Rs/(Rs + Ua)
    a3 = Rs*(exp(U0/KT) - 1)*(1/(Rs+Ua) - 1/(Rs+Ua+Ub)) + 1


    DO i = 1,nbins
        r(i) = Rr
        IF(Rr > Rs .AND. Rr <= (Rs + Ua)) THEN
            Cumm(i) = Cumm(i-1) + (a1/3.*(r(i)+dr)**3 - Rs/2.*(r(i)+dr)**2 - a1/3.*r(i)**3 + Rs/2.*r(i)**2)
        ELSEIF(Rr > (Rs + Ua) .AND. Rr <= (Rs + Ua + Ub)) THEN
            Cumm(i) = Cumm(i-1) + (a2/3.*(r(i) + dr)**3 - Rs/2.*(r(i) + dr)**2 - a2/3.*r(i)**3 + Rs/2.*r(i)**2)
        ELSEIF(Rr > (Rs + Ua + Ub) .AND. Rr <= Rd) THEN
            Cumm(i) = Cumm(i-1) + (a3/3.*(r(i) + dr)**3 - Rs/2.*(r(i) + dr)**2 - a3/3.*r(i)**3 + Rs/2.*r(i)**2)
        ENDIF
        IF(Cumm(i) .LE. Cumm(i-1)) print*, 'error!!', i, Rr, Cumm(i), Cumm(i-1), Cumm(i-2)
        Rr = Rr + dr
    ENDDO
    Cumm = Cumm/Cumm(nbins)
   
    DO i = 1,npar
        CALL RANDOM_NUMBER(rand)
        DO j = 1,nbins
            IF(rand(1) < Cumm(j)) THEN
                Rr = r(j) + dr*(rand(2)-0.5)
                EXIT
            ENDIF
        ENDDO
        theta = 2*pi*rand(2)
        phi   = ACOS(2*rand(3) - 1)
        par(1,i) = Rr*COS(phi)*SIN(theta)
        par(2,i) = Rr*SIN(phi)*SIN(theta)
        par(3,i) = Rr*COS(theta) 
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

