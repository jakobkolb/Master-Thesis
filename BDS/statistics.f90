MODULE statistics

USE global

IMPLICIT NONE

CONTAINS

    SUBROUTINE dens_statistics_accum(bins)

    INTEGER, INTENT(in) :: bins
    INTEGER             :: i
    REAL(8), DIMENSION(2,bins) :: hist

    REAL(8) :: bla

    CALL histogramm(bins,hist)

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
        WRITE(dens_final, *) (REAL(i)+.5)/REAL(bins)*L/2, aver5(i), sigma5(i)
    ENDDO
    WRITE(dens_final,*)

    WRITE(rate_final, *) "this file contains data for diffusion constant, size of sink and absorption rate"
    WRITE(rate_final, *) D, sigma5(bins+1)
    WRITE(rate_final, *) sink_radius*L, aver5(bins+1), sigma5(bins+1)
    WRITE(rate_final, *) sink_radius*L, 4*pi*sink_radius*L*D*aver5(bins-1), &
                         4*pi*sink_radius*L*D*sigma5(bins-1)
    WRITE(rate_final, *)

    WRITE(*, *) aver5(bins+1), sigma5(bins+1)
    WRITE(*, *) 4*pi*D*sink_radius*L*aver5(bins), 4*pi*D*sink_radius*L*sigma5(bins)


    END SUBROUTINE statistics_output

    SUBROUTINE histogramm(bins, output)

    INTEGER, INTENT(in) :: bins
    INTEGER :: i, binnumber
    REAL    :: r, vbin
    REAL(8), DIMENSION(3)   :: POS
    INTEGER, DIMENSION(bins)  :: hist
    REAL(8), DIMENSION(:,:), INTENT(out) :: output

    hist = 0

    POS = L/2

    DO i = 1,npar
        r = SQRT(DOT_PRODUCT(par(:,i)-POS,par(:,i)-POS))
        binnumber = INT(r/(L/2)*bins)
        IF(binnumber .LE. bins .AND. binnumber > 0) THEN
            hist(binnumber) = hist(binnumber) + 1
        ENDIF
    ENDDO
    DO i = 1,bins
        vbin = 4/3*pi*((REAL(i+1)/REAL(bins)*L/2)**3 - (REAL(i)/REAL(bins)*L/2)**3)
        output(1,i) = REAL(i)/REAL(bins)*L/2
        output(2,i) = REAL(hist(i))/vbin
    ENDDO
    END SUBROUTINE histogramm

END MODULE statistics

