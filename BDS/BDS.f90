PROGRAM BDS

USE global
USE init
USE push
USE statistics

IMPLICIT NONE

    INTEGER     :: i, j
    INTEGER     :: counter=0, acc_counter=0
    REAL(8)     :: t=0, Deltat=0, ct1, ct2, wt1, wt2
    REAL(8)     :: omp_get_wtime


    CALL RANDOM_SEED

    CALL open_output_files

    !read simulation parameters

    CALL init_parameters

    !Initialize particle possition randomly

    CALL init_particles

    !Initialize Statistics for histogramms and variable accumulation

    CALL init_statistics(nbins)

    !start iteration for particles
i = 0
    DO WHILE(t<=t1)
        i = i+1
        parold = par
        !Call statistic routines for density profile and absorption rate

        IF(t >= t0) THEN
            CALL dens_statistics_accum(nbins)
        ENDIF

        !Fluctuations of Potential/Substrate particles
        CALL update_state_of_potential

        !Move particles according to overdamped Langewin eq.
        CALL move_particles
        CALL maintain_boundary_conditions(counter)
        acc_counter = acc_counter+counter
        Deltat = Deltat + dt

        IF(t >= t0) THEN 
            CALL rate_statistics_accum(counter, nbins)
        ENDIF
        t = t + dt
        IF(MOD(i,50000) == 0) THEN
            print*, t/t1*100, acc_counter/Deltat/(4.0*pi*D)
            acc_counter = 0
            Deltat = 0
        ENDIF
    ENDDO

    !Output statistics to file

    CALL statistics_output(nbins)
    
    CALL close_output_files

END PROGRAM BDS
