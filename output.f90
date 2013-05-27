MODULE output

    USE global
    
    IMPLICIT NONE

    CONTAINS

    SUBROUTINE output_system_state

    INTEGER :: output=12

    OPEN(unit=output, file='system_state.out', action='write')
    WRITE(output,*) par(CX:CZ,:)
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

    SUBROUTINE final_output_tranectory(i)

    INTEGER :: i

    CLOSE(i)

    END SUBROUTINE

END MODULE output

