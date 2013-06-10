MODULE diag

    USE global
    USE step

    IMPLICIT NONE

    CONTAINS

    SUBROUTINE simulation_diag

    REAL(8) :: energy

    CALL Energies(energy)
    WRITE(trajectoryout,*)
    WRITE(trajectoryout,*) t, par(CX:CZ,1) 

    END SUBROUTINE simulation_diag

    SUBROUTINE Energies(energy)

        REAL(8), INTENT(out) :: energy
        REAL(8)              :: ekin, epot

        CALL KineticEnergy(ekin)
        CALL PotentialEnergy(epot, DLVOpot)

        energy = ekin + epot

            WRITE(energyout,*) t,  ekin/REAL(npar_global*3) ,  epot/REAL(npar_global), energy/REAL(npar_global)

    END SUBROUTINE Energies

!----------------------------------------------------------
!Trivial calculation of kinetic energy from velocities
    SUBROUTINE KineticEnergy(ekin)

        REAL(8), INTENT(out)     :: ekin
        INTEGER     :: i

        ekin = 0

        DO i = 1,npar_global
            ekin = ekin + Parameters(Mass,INT(par(PS,i)))*SQRT(DOT_PRODUCT(par(VX:VZ,i),par(VX:VZ,i)))
        ENDDO

    END SUBROUTINE KineticEnergy

!----------------------------------------------------------
!calculation of nonbond energie from lennard jones
!interaction
    SUBROUTINE PotentialEnergy(epot,Uij)

        REAL(8), INTENT(out)     :: epot
        REAL(8), EXTERNAL        :: Uij
        INTEGER     :: i, j

        epot = 0

        DO i = 1,npar_global
            IF(i < npar_global) THEN
            DO j = i+1,npar_global
                epot = epot + Uij(par(1:props,i),par(1:props,iip(i,j)))
                !PRINT*, npar_global, i, j
            ENDDO
            ENDIF
        ENDDO

    END SUBROUTINE PotentialEnergy

!----------------------------------------------------------
!calculate lennard jones interaction for two given particles

    FUNCTION LJpot (pi, pj)

        REAL(8), DIMENSION(:), INTENT(in)   :: pi, pj
        REAL(8), DIMENSION(3)               :: r
        REAL(8)                             :: d, ds, epsij, sigmaij, LJpot
        
        sigmaij = Parameters(Radius,INT(pi(PS)))+Parameters(Radius,INT(pj(PS)))
        epsij = eps(INT(pi(PS)),INT(pj(PS)))

        r = pi(CX:CZ)-pj(CX:CZ)
        ds = sigmaij/SQRT(DOT_PRODUCT(r,r))

        LJpot = 4*epsij*(ds**12-ds**6)
        
    END FUNCTION LJpot

    FUNCTION DLVOpot(pi,pj)

        REAL(8), DIMENSION(props) :: pi, pj
        REAL(8), DIMENSION(3)     :: r
        REAL(8)                   :: d, a, kappa, lambda, C, DLVOpot

        lambda  = 1/kt                                          !Debye lengt
        kappa   = 1*SQRT(lambda)                                !Bjerrum length
        a       = (Parameters(Radius,INT(pi(PS))) & 
                + Parameters(Radius,INT(pj(PS))))/2             !mean radius of particles i, j
        C = lambda*(exp(kappa*a)/(1+kappa*a))**2    !prefactor for DLVO force after & 
                                                                !http://en.wikipedia.org/wiki/DLVO_theory
        r = pi(CX:CZ)-pj(CX:CZ)
        d = SQRT(DOT_PRODUCT(r,r))

        DLVOpot = C*exp(-kappa*d)/d

    END FUNCTION DLVOpot 
    
    SUBROUTINE MSD

    REAL(8)                 :: r
    INTEGER                 :: i, j
    REAL(8), DIMENSION(par_species) :: adr

    IF(t == dt) Edr = 0
    adr = 0
    DO i = 1,npar_global
        dr(:,i) = dr(:,i) + par(VX:VZ,i)*sqrt(dt)
        r = DOT_PRODUCT(dr(:,i),dr(:,i))
        adr(INT(par(PS,i))) = adr(INT(par(PS,i))) + r
    ENDDO

    DO i = 1,par_species
        IF(Parameters(pnumber,i) .NE. 0) adr(i) = adr(i)/Parameters(pnumber,i)/Parameters(D,i)/6
    ENDDO
    
    Edr = adr

    WRITE(Edrout, *) t, Edr

    END SUBROUTINE MSD



END MODULE diag
