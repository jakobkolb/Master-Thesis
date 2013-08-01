PROGRAM BDS

USE global
USE init
USE push
USE statistics

IMPLICIT NONE

    INTEGER     :: i, j
    INTEGER     :: counter, tcounter
    REAL(8)     :: thickness


    CALL RANDOM_SEED

!define simulation parameters

    npar= 100000
    D   = 1
    KT  = 1
    dt  = .1
    nt  = 100
    L   = 1
    sink_radius = L/5
    thickness = .1

!Allocate particle array

    ALLOCATE(par(1:3,1:npar))

!Initialize particle possition randomly

    CALL init_particles

!start iteration for particles

    tcounter = 0
    DO i = 1,nt
        CALL move_particles
        CALL sink(sink_radius,thickness,counter)
        tcounter = tcounter + counter
        print*, i, counter, tcounter  
    ENDDO

!build histogramm for density profile
    
    CALL histogramm(100)

END PROGRAM BDS
