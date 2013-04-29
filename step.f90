MODULE step

    USE global

    IMPLICIT NONE

    CONTAINS

!==========================================================
!Routines to solve Brownian equations of Motion 


!----------------------------------------------------------
!Calculate force vektor for particles 

    SUBROUTINE calc_interactions

        INTEGER         :: i, j
        WRITE(*,*) 'calc_interactions'

        DO i=1,npar_global
            DO j=1,iip_length
                force(1:3,i) = force(1:3,i)+force12(par(i,1:props),par(iip(i,j),1:props))
            ENDDO
        ENDDO

    END SUBROUTINE calc_interactions

    FUNCTION force12(p1, p2)

        REAL(8), DIMENSION(props) :: p1, p2
        REAL(8), DIMENSION(3)   :: force12, r
        REAL(8)                 :: d, ds, epsij, sigmaij
        
        sigmaij = sigma(INT(p1(PS)),INT(p2(PS)))
        epsij = eps(INT(p1(PS)),INT(p2(PS)))

        r = p1(2:4)-p2(2:4)
        ds = sigmaij/SQRT(DOT_PRODUCT(r,r))

        force12 = r*4*epsij/sigmaij/sigmaij*(12*ds**14-6*ds**8)

    END FUNCTION force12

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
