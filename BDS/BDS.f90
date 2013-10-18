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

    CALL CPU_TIME(ct1)
    wt1 = omp_get_wtime()

!Initialize particle possition randomly

    CALL init_particles

!Initialize Statistics for histogramms and variable accumulation

    CALL init_statistics(nbins)

!start iteration for particles
    DO i = 1,nt

    IF(mod(i,int(nt/100)) .EQ. 0) WRITE(*,*) INT(REAL(i)/real(nt)*100), '% done'

        IF( t*D/sink_radius**2 > 3) THEN
            CALL dens_statistics_accum(nbins)
        ENDIF
        
        parold = par

        CALL move_particles
        CALL maintain_boundary_conditions(counter)

        IF( t/D/sink_radius > 3) THEN
            CALL rate_statistics_accum(counter, nbins)
        ENDIF

        t = t + dt
    ENDDO

    print*, 'finalize simulation for j=', j

    DEALLOCATE(par)
    DEALLOCATE(parold)

!build histogramm for density profile

    CALL statistics_output(nbins)
    
    CALL CPU_TIME(ct2)
    wt2 = omp_get_wtime()

    print*, (ct2-ct1), (ct2-ct1)/npar/nt
    print*, (wt2-wt1), (wt2-wt1)/npar/nt



    CALL close_output_files

END PROGRAM BDS
