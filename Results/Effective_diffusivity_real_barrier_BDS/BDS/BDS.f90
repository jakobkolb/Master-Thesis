PROGRAM BDS

USE global
USE init
USE push
USE statistics

IMPLICIT NONE

    INTEGER     :: i, j, n=0
    INTEGER     :: counter=0, acc_count
    REAL(8)     :: ct1, ct2, wt1, wt2
    REAL(8)     :: omp_get_wtime


    CALL RANDOM_SEED

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
        !Fluctuations of Potential/Substrate particles
        CALL update_state_of_potential

        !Move particles according to overdamped Langewin eq.
        CALL move_particles

        !Call statistic routines for density profile, mean squard displ. and
        !force field

        IF(t >= t0) THEN
            CALL dens_statistics_accum(nbins)
        ENDIF
        
        !call boundary condition routine and cound absorbed particles

        CALL maintain_boundary_conditions(counter)
        acc_count = acc_count + counter

        IF(t >= t0) THEN
            CALL write_trajectory
        ENDIF

        !call statistics routine for absorption rate

        IF(t >= t0) THEN 
            CALL rate_statistics_accum(counter, nbins)
        ENDIF

        t = t + dt
        IF(MOD(i,INT((t1/dt)/4)) == 0 .AND. t >= t0) THEN
print *, acc_count
            acc_count = 0
print*, i, t, t/t1*100, INT(t/t1*100)
            n = n+1
            CALL statistics_output(nbins, n, t)
        ENDIF 
    ENDDO

END PROGRAM BDS
