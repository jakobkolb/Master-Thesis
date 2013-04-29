MODULE step

    USE global

    IMPLICIT NONE

    CONTAINS

!==========================================================
!Routines to solve Brownian equations of Motion 


!----------------------------------------------------------
!Calculate force vektor for particles 

    SUBROUTINE calc_interactions

        WRITE(*,*) 'calc_interactions'

    END SUBROUTINE calc_interactions

!----------------------------------------------------------
!check for collisions and absorption in sink (nanoparticle)

    SUBROUTINE check_collisions

        WRITE(*,*) 'check_collisions'

    END SUBROUTINE check_collisions

!----------------------------------------------------------
!Integrator for eqm (RK?)

    SUBROUTINE move_particles

        WRITE(*,*) 'move_particles'

    END SUBROUTINE move_particles

END MODULE step
