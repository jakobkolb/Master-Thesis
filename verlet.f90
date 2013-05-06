MODULE verlet

    USE global

    IMPLICIT NONE

    CONTAINS 

    SUBROUTINE init_iip

    INTEGER :: i, j, k

    ALLOCATE(iip(1:npar_global,1:npar_global))

    DO i=1,npar_global
        k=1
        DO j=1,npar_global
            iip(i,j)=k
            k=k+1
        ENDDO
    ENDDO

    iip_length = npar_global

    END SUBROUTINE init_iip

    SUBROUTINE update_iip

        WRITE(*,*) '->update_iip'


    END SUBROUTINE update_iip



END MODULE verlet

