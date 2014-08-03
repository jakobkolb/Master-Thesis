MODULE global

IMPLICIT NONE

    REAL(8), PARAMETER                      :: pi = 3.14159265359
    REAL(8), DIMENSION(:,:), ALLOCATABLE    :: par
    REAL(8), DIMENSION(:,:), ALLOCATABLE    :: parold
    REAL(8), DIMENSION(:,:), ALLOCATABLE    :: force
    INTEGER                                 :: npar, nbins, nmult
    REAL(8)                                 :: D, KT, dt, Rs=1, Rd, msqd, md
    REAL(8)                                 :: t0, t1,t, U0, U1, l, g, Un, a, b, K01, K10, fmode, decay_length
    CHARACTER(3)                            :: potential_shape    
    CHARACTER(5)                            :: measure

    INTEGER :: dens_final, rate_final

END MODULE global