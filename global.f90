MODULE global

    IMPLICIT NONE
! ===== Particle property indices
!In the integration steps arrays are needed, which contain the following properties
!for each particle, also called particle data. By the following variables
!the program can determine the array size and at what exact index
!to store a special property

    INTEGER, PARAMETER :: prop=7    !number of particle properties
    INTEGER, PARAMETER :: PS=1      !particle species
    INTEGER, PARAMETER :: CX=2      !x-coordinate
    INTEGER, PARAMETER :: CY=3      !y-coordinate
    INTEGER, PARAMETER :: CZ=4      !z-coordinate
    INTEGER, PARAMETER :: VX=5      !x-velocity
    INTEGER, PARAMETER :: VY=6      !y-velocity
    INTEGER, PARAMETER :: VZ=7      !z-velocity

! The following arrays will contain the systems status

    REAL(re8), DIMENSION(:,:), ALLOCATABLE  :: par  !particle data (r,v) dimension:2*dim x npar
    REAL(re8), DIMENSION(:,:), ALLOCATABLE  :: force!force on each particle dimension:dim x npar
    REAL(re8), DIMENSION(:,:), ALLOCATABLE  :: iip  !indices of interacting particles within Rc

!parameters in input file (with default  values)

    INTEGER                 :: npar_global=10   !total number of particles
    INTEGER, DIMENSION(:)   :: npar_species     !number of particles for each species [NPS1, ..., NPSN]
    INTEGER                 :: nt=100           !number of time steps
    REAL(8)                 :: dt=1             !time stepsize (might have to be updated on runtime)

    REAL(8), DIMENSION(:,:) :: epsij            !parameters for Lennard Jones interaction (symmetric)
    REAL(8), DIMENSION(:,:) :: sigma            !diameter of particles relative to particle 1
    REAL(8), DIMENSION(:)   :: zeta             !frictionconstant/particle mass for equation of motion
    REAL(8)                 :: kt               !Kb*T thermal Energy of the system

    NAMELIST /PARAMETER/ npar_global, npar_species, nt, kt

CONTAINS

!==========================================================

    SUBROUTINE global_init

        INTEGER, PARAMETER :: in=10

!----------------------------------------------------------
!Setting and loading main parameters for the calculation

        OPEN(unit=in, file="CSBD.in")
        READ(in,PARAMETER)
        CLOSE(in)

    END SUBROUTINE global_init
 

END MODULE global
