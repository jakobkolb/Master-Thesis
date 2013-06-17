PROGRAM CSBD

    USE global
    USE verlet
    USE init
    USE step
    USE output
    USE diag

    IMPLICIT NONE

    INTEGER :: i

!----------------------------------------------------------
!prepare simulation (load parameters, allocate arrays etc, innitial conditions)

    WRITE(*,*) '#######prepare simulation#######'

    CALL init_global        !load simulation parameters and allocate arrays
    CALL init_iip           !initialize list of interacting particles
    CALL init_particles     !initialize particle coordinates and velocity distribution
    CALL open_files         !initialize file output
    CALL init_statistics    !init variables for statistic evaluation

!----------------------------------------------------------
!central iteration loop

    WRITE(*,*) '#######start simulation#######'

    DO i=1,nt
        CALL move_particles         !routine to move particles according to dynamic equations
        CALL MSD                    !calculate mean square displacement
        print*, t
        IF(MODULO(i,ndiag)==0) THEN
            CALL simulation_diag
        ENDIF
    ENDDO

!----------------------------------------------------------
!finalize simulation

    WRITE(*,*) '#######finalize simulation#######'

    CALL output_system_state 

    CALL close_files
    CALL free_memory

END PROGRAM CSBD
