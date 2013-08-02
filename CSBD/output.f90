MODULE output

    USE global
    
    IMPLICIT NONE

    CONTAINS

    SUBROUTINE output_system_state

    INTEGER, PARAMETER  :: output=12
    INTEGER             :: i, j, k
    
    k = 0
    OPEN(unit=output, file='system_state.out', action='write')
    DO i = 1,par_species
        IF(Parameters(pnumber,i) .NE. 0) THEN
        DO j = 1,INT(Parameters(pnumber,i))
            k = k + 1
            WRITE(output,*) k, par(CX:CZ,k)
        ENDDO
        WRITE(output,*)
        ENDIF
    ENDDO
    CLOSE(output) 

    END SUBROUTINE 

    SUBROUTINE init_output_trajectory(i)

    INTEGER :: i
    CHARACTER(len=17) :: filestring

    WRITE(filestring, "(A11,I2,A4)" ) 'trajectory_', i, '.out'

    OPEN(unit=i, file=filestring, action='write')

    END SUBROUTINE

    SUBROUTINE output_trajectory(i)

    INTEGER :: i
    
    END SUBROUTINE

    SUBROUTINE final_output_trajectory(i)

    INTEGER :: i

    CLOSE(i)

    END SUBROUTINE

END MODULE output

