PROGRAM BDS

USE global
USE init
USE push
USE statistics

IMPLICIT NONE

    INTEGER     :: i, j
    INTEGER     :: counter
    REAL(8)     :: t=0, ct1, ct2, wt1, wt2
    REAL(8)     :: omp_get_wtime


    CALL RANDOM_SEED

    CALL open_output_files

!read simulation parameters

    CALL init_parameters

!Iterate over scan Parameter

DO j = 1,20
    sink_radius = sink_radius + 0.005
    CALL CPU_TIME(ct1)
    wt1 = omp_get_wtime()

    U1 = U1 + 0.01

!Initialize particle possition randomly

    CALL init_particles

!Initialize Statistics for histogramms and variable accumulation

    CALL init_statistics(nbins)

!start iteration for particles

    print*, 'run simulation for j=', j

    DO i = 1,nt

        IF( t*D > 1) THEN
            CALL dens_statistics_accum(nbins)
        ENDIF
        
        parold = par

        CALL move_particles
        CALL sink(counter)

        IF( t/D > 10) THEN
            CALL rate_statistics_accum(counter, nbins)
        ENDIF

        t = t + dt
    ENDDO

    print*, 'finalize simulation for j=', j

    DEALLOCATE(par)
    DEALLOCATE(parold)
    DEALLOCATE(dr)
!build histogramm for density profile

    CALL statistics_output(nbins)
    
ENDDO

    CALL CPU_TIME(ct2)
    wt2 = omp_get_wtime()

    print*, (ct2-ct1), (ct2-ct1)/npar/nt/j
    print*, (wt2-wt1), (wt2-wt1)/npar/nt/j



    CALL close_output_files

END PROGRAM BDS
