MODULE global

IMPLICIT NONE

    REAL(8), PARAMETER                      :: pi = 3.14159265359
    REAL(8), DIMENSION(:,:), ALLOCATABLE    :: par
    REAL(8), DIMENSION(:,:), ALLOCATABLE    :: parold
    INTEGER                                 :: npar
    REAL(8)                                 :: D, KT, dt, L
    INTEGER                                 :: nt
    REAL(8)                                 :: sink_radius, thickness

    INTEGER :: dens_final, rate_final

END MODULE global