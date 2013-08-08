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

    CALL open_output_files

!define simulation parameters

    npar= 10000
    D   = 1
    KT  = 1
    dt  = .1
    nt  = 10000
    L   = 100
    sink_radius = 0
    thickness = .1
DO j = 1,5
    sink_radius = sink_radius + 0.001


!Allocate particle array

    ALLOCATE(par(1:3,1:npar))

!Initialize particle possition randomly

    CALL init_particles
    CALL init_statistics(100)

!start iteration for particles

    tcounter = 0
    DO i = 1,nt

        IF( t/D > 10) THEN
            CALL dens_statistics_accum(100)
        ENDIF

        CALL move_particles
        CALL sink(sink_radius,thickness,counter)
        tcounter = tcounter + counter

!        IF(MODULO(i,10) == 0) THEN
!            print*, i, counter, tcounter
!        ENDIF

        IF( t/D > 10) THEN
            CALL rate_statistics_accum(counter, 100)
        ENDIF

        t = t + dt
    ENDDO

    DEALLOCATE(par)

!build histogramm for density profile

    CALL statistics_output(100)
    
ENDDO
    CALL close_output_files

END PROGRAM BDS
