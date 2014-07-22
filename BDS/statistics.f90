MODULE statistics

USE global

IMPLICIT NONE

CONTAINS

    SUBROUTINE dens_statistics_accum(bins)

    INTEGER, INTENT(in) :: bins
    INTEGER             :: i, j
    REAL(8), DIMENSION(2,bins) :: hist

    !calculate histogramm of particle distance to sink

    CALL histogramm(par, hist, bins)

    !accumulate density histrogramm in statistics module

    DO i = 1,2
        DO j = 1,bins
            CALL accum5(j+(i-1)*bins,hist(i,j)) 
        ENDDO
    ENDDO

    END SUBROUTINE dens_statistics_accum

    SUBROUTINE histogramm(X, Xhist, bins)

    INTEGER, INTENT(in) :: bins
    INTEGER :: i, imax, binnumber
    REAL    :: r, vbin
    REAL(8), DIMENSION(3)   :: POS
    REAL(8), DIMENSION(2,bins), INTENT(out) :: Xhist
    REAL(8), DIMENSION(:,:), INTENT(in)  :: X

    Xhist = 0
    imax = SIZE(X,2)

    !build histogramm according to particle distance to sink

    !$OMP PARALLEL DO REDUCTION(+:Xhist) PRIVATE(binnumber, r)
    DO i = 1,imax
        r = SQRT(DOT_PRODUCT(X(1:3,i),X(1:3,i)))
        binnumber = INT(r/Rd*bins)
        IF(binnumber .LE. bins) THEN
            IF(binnumber .LE. 0)print*, i, r, X(:,i)
            IF(X(4,i) == 0 .AND. binnumber .GE. 0) THEN
                Xhist(1,binnumber) = Xhist(1,binnumber) + 1
            ELSEIF(X(4,i) == 1 .AND. binnumber .GE. 0) THEN
                Xhist(2,binnumber) = Xhist(2,binnumber) + 1
            ENDIF
        ENDIF
    ENDDO
    !$OMP END PARALLEL DO

    END SUBROUTINE histogramm

    SUBROUTINE rate_statistics_accum(counter, bins)

    INTEGER, INTENT(in) :: counter, bins
    REAL(8)             :: rate

    !calculate absorption rate: rate=apsorbed particles/unit time

    rate = counter/dt

    !accumulate absorption rate in statistics module

    CALL accum5(2*bins+1,rate)

    END SUBROUTINE rate_statistics_accum

    SUBROUTINE statistics_output(bins,n)
    
    INTEGER, INTENT(in) :: bins
    INTEGER             :: i, n
    REAL(8)             :: aver5, sigma5, a, b, Rr
    CHARACTER(len=128)  :: dens_file, rate_file

    !Create names for output files

    WRITE(dens_file, "(A9,I0.2)") "dens_data", n
    WRITE(rate_file, "(A9,I0.2)") "rate_data", n

    PRINT *, TRIM(dens_file)
    PRINT *, TRIM(rate_file)

    !Open files for output

    dens_final  = 20
    rate_final  = 21

    OPEN(unit=dens_final, file=dens_file, action="write")
    OPEN(unit=rate_final, file=rate_file, action="write")

    !Write statistics output to file
    
    DO i = 1,bins
        Rr = real(i)*Rd/real(bins)
        WRITE(dens_final, "(7f15.4)")   (REAL(i))/REAL(bins)*Rd, aver5(i), sigma5(i), &
                                        aver5(i + bins), sigma5(i + bins)
    ENDDO

    WRITE(rate_final, *) "this file contains simulation parameters and measured absorption rate"
    WRITE(rate_final, *)
    WRITE(rate_final, "(E10.5, 1x, E10.5, 1x, E10.5, 1x ,&
    E10.5, 1x, E10.5, 1x, E10.5, 1x, E10.5, 1x, E10.5, &
    1x, E10.5, 1x, E10.5, 1x, E10.5, 1x, E10.5, 1x, &
    E10.5, 1x, E10.5)")&
    REAL(npar), D, Rs, Rd, t0, t1, U0, U1, l, g, K01, K10, aver5(2*bins+1), sigma5(2*bins+1)

    !Close files for output

    CLOSE(dens_final)
    CLOSE(rate_final)

    !And reset stat5

    CALL clear5(2*bins+1,500)

    END SUBROUTINE statistics_output

END MODULE statistics

