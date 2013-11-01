MODULE statistics

USE global

IMPLICIT NONE

CONTAINS

    SUBROUTINE dens_statistics_accum(bins)

    INTEGER, INTENT(in) :: bins
    INTEGER             :: i
    REAL(8), DIMENSION(2,bins) :: hist

    !calculate histogramm of particle distance to sink

    CALL histogramm(par, hist, bins)

    !accumulate density histrogramm in statistics module

    DO i = 1,bins
        CALL accum5(i,hist(2,i)) 
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
        r = SQRT(DOT_PRODUCT(X(:,i),X(:,i)))
        binnumber = INT(r/Rd*bins)
        IF(binnumber .LE. bins) THEN
            Xhist(2,binnumber) = Xhist(2,binnumber) + 1
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

    CALL accum5(bins+1,rate)

    END SUBROUTINE rate_statistics_accum

    SUBROUTINE statistics_output(bins)
    
    INTEGER, INTENT(in) :: bins
    INTEGER             :: i
    REAL(8)             :: aver5, sigma5

    !Write statistics output to file

    DO i = 1,bins
        WRITE(dens_final, *) (REAL(i))/REAL(bins)*Rd, aver5(i), sigma5(i)
    ENDDO

    WRITE(rate_final, *) "this file contains simulation parameters and measured absorption rate"
    WRITE(rate_final, *)
    WRITE(rate_final, "(8f15.4)") npar, D, Rs, Rd, t0, t1, aver5(bins+1), sigma5(bins+1)

    END SUBROUTINE statistics_output

END MODULE statistics

