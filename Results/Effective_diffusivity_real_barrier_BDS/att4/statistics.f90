MODULE statistics

USE global

IMPLICIT NONE

CONTAINS

    SUBROUTINE dens_statistics_accum(bins)

    INTEGER, INTENT(in) :: bins
    INTEGER             :: i, j
    REAL(8), DIMENSION(2,bins) :: hist

    hist = 0

    !calculate histogramm of particle distance to sink

    CALL histogramm(par, hist, bins)

    !accumulate density histrogramm in statistics module

    DO i = 1,2
        DO j = 1,bins
            CALL accum5(j+(i-1)*bins,hist(i,j)) 
        ENDDO
    ENDDO

    hist = 0

    CALL msd(hist,bins)

    DO i = 1,2
        DO j = 1,bins
            CALL accum5(2*bins+j+(i-1)*bins,hist(i,j))
        ENDDO
    ENDDO

    hist = 0

    CALL forcehist(hist,bins)

    DO i = 1,2
        DO j = 1,bins
            CALL accum5(4*bins+j+(i-1)*bins,hist(i,j))
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
            !IF(binnumber .LE. 0)print*, i, r, X(:,i)
            IF(X(4,i) == 0 .AND. binnumber .GE. 0) THEN
                Xhist(1,binnumber) = Xhist(1,binnumber) + 1
            ELSEIF(X(4,i) == 1 .AND. binnumber .GE. 0) THEN
                Xhist(2,binnumber) = Xhist(2,binnumber) + 1
            ENDIF
        ENDIF
    ENDDO
    !$OMP END PARALLEL DO

    END SUBROUTINE histogramm

    SUBROUTINE msd(hist, bins)

    INTEGER, INTENT(in) :: bins
    INTEGER             :: imax, binnumber, i
    REAL(8), DIMENSION(3) :: dr
    REAL(8)             :: r, rsq
    REAL(8), DIMENSION(2,bins), INTENT(out)  :: hist
    REAL(8), DIMENSION(2,bins)  :: pcount

    pcount = 0
    hist = 0
    imax = SIZE(par,2)
    !$OMP PARALLEL DO REDUCTION(+:hist,pcount) PRIVATE(binnumber, r, rsq)
    DO i = 1,imax
        r = SQRT(DOT_PRODUCT(parold(1:3,i),parold(1:3,i)))
        dr = par(1:3,i) - parold(1:3,i)
        rsq = DOT_PRODUCT(dr,dr) - DOT_PRODUCT(force(:,i),force(:,i))
        IF(rsq > 1. .AND. r < 2) THEN
            WRITE(*,*) r, SQRT(DOT_PRODUCT(par(:,i),par(:,i))), rsq
            WRITE(*,*) par(:,i) - parold(:,i)
        ENDIF
        binnumber = INT(r/Rd*bins)
        IF(binnumber .LE. bins) THEN
            !IF(binnumber .LE. 0)print*, i, r, par(:,i)
            IF(par(4,i) == 0 .AND. binnumber .GE. 0) THEN
                hist(1,binnumber) = hist(1,binnumber) + rsq
                pcount(1,binnumber) = pcount(1,binnumber) + 1.0
            ELSEIF(par(4,i) == 1 .AND. binnumber .GE. 0) THEN
                hist(2,binnumber) = hist(2,binnumber) + rsq
                pcount(2,binnumber) = pcount(2,binnumber) + 1.0
            ENDIF
        ENDIF
    ENDDO
    !$OMP END PARALLEL DO

    !!$OMP PARALLEL DO
    !DO i = 1,bins
    !    IF(pcount(1,i)>0) hist(1,i) = hist(1,i)/pcount(1,i)
    !    IF(pcount(2,i)>0) hist(2,i) = hist(2,i)/pcount(2,i)
    !ENDDO
    !!$OMP END PARALLEL DO
    END SUBROUTINE msd

    SUBROUTINE forcehist(hist, bins)

    INTEGER, INTENT(in) :: bins
    INTEGER             :: imax, binnumber, i
    REAL(8)             :: r, rsq
    REAL(8), DIMENSION(2,bins), INTENT(out)  :: hist
    REAL(8), DIMENSION(2,bins)  :: pcount

    pcount = 0
    hist = 0
    imax = SIZE(par,2)
    !$OMP PARALLEL DO REDUCTION(+:hist,pcount) PRIVATE(binnumber, r, rsq)
    DO i = 1,imax
        IF(DOT_PRODUCT(force(:,i),force(:,i)) > 1.0) THEN
            WRITE(*,*) SQRT(DOT_PRODUCT(parold(:,i),parold(:,i))), SQRT(DOT_PRODUCT(force(:,i),force(:,i)))
        ENDIF
        r = SQRT(DOT_PRODUCT(parold(1:3,i),parold(1:3,i)))
        rsq = SQRT(DOT_PRODUCT(force(:,i)/dt,force(:,i)/dt))
        binnumber = INT(r/Rd*bins)
        IF(binnumber .LE. bins) THEN
            !IF(binnumber .LE. 0)print*, i, r, par(:,i)
            IF(par(4,i) == 0 .AND. binnumber .GE. 0) THEN
                hist(1,binnumber) = hist(1,binnumber) + rsq
                pcount(1,binnumber) = pcount(1,binnumber) + 1
            ELSEIF(par(4,i) == 1 .AND. binnumber .GE. 0) THEN
                hist(2,binnumber) = hist(2,binnumber) + rsq
                pcount(2,binnumber) = pcount(2,binnumber) + 1
            ENDIF
        ENDIF
    ENDDO
    !$OMP END PARALLEL DO

    !$OMP PARALLEL DO
    DO i = 1,bins
        IF(pcount(1,i)>0) hist(1,i) = hist(1,i)/pcount(1,i)
        IF(pcount(2,i)>0) hist(2,i) = hist(2,i)/pcount(2,i)
    ENDDO
    !$OMP END PARALLEL DO
    END SUBROUTINE forcehist


    SUBROUTINE rate_statistics_accum(counter, bins)

    INTEGER, INTENT(in) :: counter, bins
    REAL(8)             :: rate

    !calculate absorption rate: rate=apsorbed particles/unit time

    rate = counter/dt

    !accumulate absorption rate in statistics module

    CALL accum5(6*bins+1,rate)

    END SUBROUTINE rate_statistics_accum

    SUBROUTINE statistics_output(bins,n,t)
    
    INTEGER, INTENT(in) :: bins
    INTEGER             :: i, n, msqd_final, force_final
    REAL(8)             :: aver5, sigma5, a, b, Ua, Ub, Rr, t
    CHARACTER(len=128)  :: dens_file, rate_file, msqd_file, force_file

    !Create names for output files

    WRITE(dens_file, "(A9,I0.2)") "dens_data", n
    WRITE(rate_file, "(A9,I0.2)") "rate_data", n
    WRITE(msqd_file, "(A9,I0.2)") "msqd_data", n
    WRITE(force_file, "(A9,I0.2)") "forc_data", n

    !Open files for output

    dens_final  = 20
    msqd_final  = 21
    rate_final  = 22
    force_final = 23

    OPEN(unit=dens_final, file=dens_file, action="write")
    OPEN(unit=msqd_final, file=msqd_file, action="write")
    OPEN(unit=rate_final, file=rate_file, action="write")
    OPEN(unit=force_final, file=force_file, action="write")

    !Write density profile output to file
    
    DO i = 1,bins-1
        Rr = real(i)*Rd/real(bins)
        WRITE(dens_final, "(7f15.4)")   (REAL(i)+1)/REAL(bins)*Rd, aver5(i), sigma5(i), &
                                        aver5(i + bins), sigma5(i + bins)
    ENDDO

    !Calculate parameters for ideal barrier

    Ua = 1+l 
    Ub = 1+(1+g)*l

    !Calculate parameters for gaussian barrier

    a = (Ua+Ub)/2.0
    b = (Ub-Ua)/2.0

    !write mean square displacement to file

    DO i = 1,bins-1
        Rr = real(i)*Rd/real(bins)
        WRITE(msqd_final, '(6ES17.7E3)')   (REAL(i)+1)/REAL(bins)*Rd, aver5(i+2*bins), sigma5(i+2*bins), &
                                        aver5(i + 3*bins), sigma5(i + 3*bins), (EXP(-((-a+Rr)/b)**Un)*Un*((-a+Rr)/b)**Un*U1)/(a-Rr)
    ENDDO

    !write force histogram to file

    DO i = 1,bins-1
        Rr = real(i)*Rd/real(bins)
        WRITE(force_final, '(6ES17.7E3)')   (REAL(i)+1)/REAL(bins)*Rd, aver5(i+4*bins), sigma5(i+4*bins), &
                                        aver5(i + 5*bins), sigma5(i + 5*bins), (EXP(-((-a+Rr)/b)**Un)*Un*((-a+Rr)/b)**Un*U1)/(a-Rr)
    ENDDO

    WRITE(rate_final, *) "this file contains simulation parameters and measured absorption rate"
    WRITE(rate_final, *)
    WRITE(rate_final, "(E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5, 1x, E12.5)")&
    REAL(npar), D, Rd, dt, t0, t1, t, U0, U1, l, g, decay_length, aver5(6*bins+1), sigma5(6*bins+1)
    
    !Close files for output

    CLOSE(dens_final)
    CLOSE(dens_final)
    CLOSE(msqd_final)

    !And reset stat5

    CALL clear5(6*bins+1,500)

    END SUBROUTINE statistics_output

END MODULE statistics

