MODULE global

IMPLICIT NONE

    REAL(8), PARAMETER                      :: pi = 3.14159265359
    REAL(8), DIMENSION(:,:), ALLOCATABLE    :: par
    REAL(8), DIMENSION(:,:), ALLOCATABLE    :: parold
    INTEGER                                 :: npar, nbins
    REAL(8)                                 :: D, KT, dt, Rs, Rd, thickness, tcount
    REAL(8)                                 :: U1, gap, U0, t0, t1

    INTEGER :: dens_final, rate_final

END MODULE global
