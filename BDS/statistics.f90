MODULE statistics

USE global

IMPLICIT NONE

CONTAINS

    SUBROUTINE histogramm(bins)

    INTEGER :: bins, i, binnumber
    REAL    :: r, vbin
    INTEGER, DIMENSION(:), ALLOCATABLE  :: hist

    ALLOCATE(hist(1:bins))

    DO i = 1,npar
        r = SQRT(DOT_PRODUCT(par(:,i)-L/2,par(:,i)-L/2))
        binnumber = INT(r/L*bins)
        print*, binnumber
        IF(binnumber .LE. bins) THEN
            hist(binnumber) = hist(binnumber) + 1
        ENDIF
    ENDDO

    OPEN(unit=20, file="dens_profile.out", action="write")
    DO i = 1,bins
        vbin = 4/3*pi*((REAL(i+1)/REAL(bins)*L)**3 - (REAL(i)/REAL(bins)*L)**3)
        print*, hist(i)/vbin, hist(i)
        WRITE(20,*) REAL(i)/REAL(bins)*L, REAL(hist(i))/vbin
    ENDDO
    CLOSE(20)

    END SUBROUTINE histogramm

END MODULE statistics

