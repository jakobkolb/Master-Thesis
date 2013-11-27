MODULE global

IMPLICIT NONE

    REAL(8), PARAMETER                      :: pi = 3.14159265359
    REAL(8), DIMENSION(:,:), ALLOCATABLE    :: par
    REAL(8), DIMENSION(:,:), ALLOCATABLE    :: parold
    INTEGER                                 :: npar, nbins
    REAL(8)                                 :: D, KT, dt, Rs, Rd, msqd, md
    REAL(8)                                 :: t0, t1, U0, U1, Ua, Ub, Un, a, b, K01, K10, fmode

    INTEGER :: dens_final, rate_final

END MODULE global
