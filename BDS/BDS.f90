PROGRAM BDS

USE global
USE init
USE push
USE statistics

IMPLICIT NONE

    INTEGER     :: i, j
    INTEGER     :: counter
    REAL(8)     :: t=0


    CALL RANDOM_SEED

    CALL open_output_files


!read simulation parameters

    CALL init_parameters

!Iterate over scan Parameter

DO j = 1,4
    sink_radius = sink_radius + 0.01

!Initialize particle possition randomly

    CALL init_particles

!Initialize Statistics for histogramms and variable accumulation

    CALL init_statistics(100)

!start iteration for particles

    DO i = 1,nt

        IF( t*D > 1) THEN
            CALL dens_statistics_accum(100)
        ENDIF
        
        parold = par

        CALL move_particles
        CALL sink(counter)

!        IF(MODULO(i,10) == 0) THEN
!            print*, i, counter, tcounter
!        ENDIF

        IF( t/D > 10) THEN
            CALL rate_statistics_accum(counter, 100)
        ENDIF

        t = t + dt
    ENDDO

    DEALLOCATE(par)
    DEALLOCATE(parold)

!build histogramm for density profile

    CALL statistics_output(100)
    
ENDDO
    CALL close_output_files

END PROGRAM BDS
