PROGRAM CSBD

    USE global
    USE verlet
    USE init
    USE step

    IMPLICIT NONE

    INTEGER :: i

!----------------------------------------------------------
!prepare simulation (load parameters, allocate arrays etc, innitial conditions)

    WRITE(*,*) '#######prepare simulation#######'

    CALL init_global        !load parameters and allocate arrays
    CALL init_iip           !initialize list of interacting particles
    CALL init_particles     !initialize particle coordinates and velocity distribution
!    CALL open_files         !initialize file output

!----------------------------------------------------------
!central iteration loop

    WRITE(*,*) '#######start simulation#######'

    DO i=1,nt
       CALL calc_interactions
       CALL check_collisions
!       IF(MODULO(i,nlc)==0) THEN
!           CALL verlet_list
!       ENDIF
       CALL move_particles
!       IF(MODULO(i,ndiag)==0) THEN
!           CALL simulation_diag
!       ENDIF
    ENDDO

!----------------------------------------------------------
!finalize simulation

    WRITE(*,*) '#######finalize simulation#######'

!   CALL close_files
!   CALL free_memory

END PROGRAM CSBD
