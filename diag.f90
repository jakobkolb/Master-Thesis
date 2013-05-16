MODULE diag

    USE global
    USE step

    IMPLICIT NONE

    CONTAINS

    SUBROUTINE Energies

        REAL(8) :: energy

        energy = ekin() + epot()

        WRITE(*,*) energy

    END SUBROUTINE Energies

!----------------------------------------------------------
!Trivial calculation of kinetic energy from velocities
    FUNCTION ekin()

        REAL(8)     :: ekin
        INTEGER     :: i

        ekin = 0

        DO i = 1,npar_global
            ekin = ekin + mass(INT(par(PS,i)))*SQRT(SUM(par(VX:VZ)))
        ENDDO

    END FUNCTION ekin

!----------------------------------------------------------
!calculation of nonbond energie from lennard jones
!interaction
    FUNCTION epot()

        REAL(8)     :: epot
        INTEGER     :: i, j

        DO i = 1,npar_global
            DO j = i+1,npar_global
                epot = epot + Ulj(par(1:props,i),par(1:props,iip(i,j))
            ENDDO
        ENDDO

    END FUNCTION epot

!----------------------------------------------------------
!calculate lennard jones interaction for two given particles

    FUNCTION Ulj (pi, pj)

        REAL(8), DIMENSION(:), INTENT(in)   :: pi, pj
        REAL(8), DIMENSION(3)               :: r
        REAL(8)                             :: d, ds, epsij, sigmaij, Ulj
        
        sigmaij = sigma(INT(pi(PS)),INT(pj(PS)))
        epsij = eps(INT(pi(PS)),INT(pj(PS)))

        r = pi(CX:CZ)-pj(CX:CZ)
        ds = sigmaij/SQRT(DOT_PRODUCT(r,r))

        Ulj = 4*epsij*(ds**12-ds**6)
        
    END FUNCTION Ulj

END MODULE diag
