MODULE statistics

USE global

IMPLICIT NONE

CONTAINS

    SUBROUTINE dens_statistics_accum(bins)

    INTEGER, INTENT(in) :: bins
    INTEGER             :: i
    REAL(8), DIMENSION(2,bins) :: hist

    CALL histogramm(par, hist, bins)

    DO i = 1,bins
        CALL accum5(i,hist(2,i)) 
    ENDDO

    END SUBROUTINE dens_statistics_accum

    SUBROUTINE rate_statistics_accum(counter, bins)

    INTEGER, INTENT(in) :: counter, bins
    REAL(8)             :: rate

    rate = counter/dt

    CALL accum5(bins+1,rate)

    END SUBROUTINE rate_statistics_accum

    SUBROUTINE statistics_output(bins)
    
    INTEGER, INTENT(in) :: bins
    INTEGER             :: i
    REAL(8)             :: aver5, sigma5


    DO i = 1,bins
        WRITE(dens_final, *) (REAL(i))/REAL(bins)*L/SQRT(2.), aver5(i), sigma5(i)
    ENDDO
    WRITE(dens_final,*)

    WRITE(rate_final, *) "this file contains data for diffusion constant, size of sink and measured absorption rate"
    WRITE(rate_final, *) sink_radius, aver5(bins+1), sigma5(bins+1)
    WRITE(rate_final, *)

    END SUBROUTINE statistics_output

    SUBROUTINE histogramm(X, Xhist, bins)

    INTEGER, INTENT(in) :: bins
    INTEGER :: i, imax, binnumber
    REAL    :: r, vbin
    REAL(8), DIMENSION(3)   :: POS
    INTEGER, DIMENSION(bins)  :: hist
    REAL(8), DIMENSION(2,bins), INTENT(out) :: Xhist
    REAL(8), DIMENSION(:,:), INTENT(in)  :: X

    hist = 0
    Xhist = 0
    imax = SIZE(X,2)
    POS = L/2

    !$OMP PARALLEL DO REDUCTION(+:hist) PRIVATE(binnumber, r)
    DO i = 1,imax
        r = SQRT(DOT_PRODUCT(X(:,i)-POS,X(:,i)-POS))
        binnumber = INT(r/(L/SQRT(2.))*bins)
        IF(binnumber < bins) THEN
            hist(binnumber) = hist(binnumber) + 1
        ENDIF
    ENDDO
    !$OMP END PARALLEL DO

    DO i = 1,bins
        vbin = 4/3*pi*((REAL(i+1)/REAL(bins)*L/SQRT(2.))**3 - (REAL(i)/REAL(bins)*L/SQRT(2.))**3)
        Xhist(1,i) = (REAL(i))/REAL(bins)*L/SQRT(2.)
        Xhist(2,i) = REAL(hist(i))/vbin
    ENDDO

    END SUBROUTINE histogramm

END MODULE statistics

