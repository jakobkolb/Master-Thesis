PROGRAM BDS

USE global
USE init
USE push
USE statistics

IMPLICIT NONE

    INTEGER     :: i, j
    INTEGER     :: counter, tcounter
    REAL(8)     :: thickness, t=0


    CALL RANDOM_SEED

!define simulation parameters

    npar= 1000
    D   = 1
    KT  = 1
    dt  = .01
    nt  = 20000
    L   = 20
    sink_radius = .05
    thickness = .1

!Allocate particle array

    ALLOCATE(par(1:3,1:npar))

!Initialize particle possition randomly

    CALL init_particles
    CALL init_statistics(100)
    CALL open_output_files

!start iteration for particles

    tcounter = 0
    DO i = 1,nt

        IF( t/D > 10) THEN
            CALL dens_statistics_accum(100)
        ENDIF

        CALL move_particles
        CALL sink(sink_radius,thickness,counter)
        tcounter = tcounter + counter

        IF(MODULO(i,10) == 0) THEN
            print*, i, counter, tcounter
        ENDIF

        IF( t/D > 10) THEN
            CALL rate_statistics_accum(counter, 100)
        ENDIF

        t = t + dt
    ENDDO

!build histogramm for density profile

    CALL statistics_output(100)
    
    CALL close_output_files

END PROGRAM BDS
