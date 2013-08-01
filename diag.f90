MODULE diag

    USE global
    USE step

    IMPLICIT NONE

    CONTAINS

   
    SUBROUTINE MSD

    REAL(8)                 :: r
    INTEGER                 :: i, j
    REAL(8), DIMENSION(par_species) :: adr

    IF(t == dt) Edr = 0
    adr = 0
    DO i = 1,npar_global
        dr(:,i) = dr(:,i) + par(VX:VZ,i)*sqrt(dt)
        r = DOT_PRODUCT(dr(:,i),dr(:,i))
        adr(INT(par(PS,i))) = adr(INT(par(PS,i))) + r
    ENDDO

    DO i = 1,par_species
        IF(Parameters(pnumber,i) .NE. 0) adr(i) = adr(i)/Parameters(pnumber,i)
    ENDDO
    
    Edr = adr

    WRITE(Edrout, *) t, Edr

    END SUBROUTINE MSD



END MODULE diag
