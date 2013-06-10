
MODULE global

    IMPLICIT NONE
! ===== Particle property indices
!In the integration steps arrays are needed, which contain the following properties
!for each particle, also called particle data. By the following variables
!the program can determine the array size and at what exact index
!to store a special property

    INTEGER, PARAMETER :: props=7   !number of particle properties
    INTEGER, PARAMETER :: PS=1      !particle species
    INTEGER, PARAMETER :: CX=2      !x-coordinate
    INTEGER, PARAMETER :: CY=3      !y-coordinate
    INTEGER, PARAMETER :: CZ=4      !z-coordinate
    INTEGER, PARAMETER :: VX=5      !x-velocity
    INTEGER, PARAMETER :: VY=6      !y-velocity
    INTEGER, PARAMETER :: VZ=7      !z-velocity

! The following arrays will contain the systems status

    REAL(8), DIMENSION(:,:), ALLOCATABLE  :: par  !particle data (r,v) dimension:2*dim x npar
    REAL(8), DIMENSION(:,:), ALLOCATABLE  :: force!force on each particle dimension:dim x npar
    INTEGER, DIMENSION(:,:), ALLOCATABLE  :: iip  !indices of interacting particles within Rc

! Indices of properties of particles

    INTEGER, PARAMETER :: nParameters = 5    !number of particle parameters
    INTEGER, PARAMETER :: Radius = 1        !radius of particles
    INTEGER, PARAMETER :: Mass   = 2        !mass of particles
    INTEGER, PARAMETER :: Charge = 3        !electric charge of species in units of e
    INTEGER, PARAMETER :: D      = 4        !Diffusion constant for particles
    INTEGER, PARAMETER :: pnumber= 5        !number of particles for species

! Parameters for particle species

    REAL(8), DIMENSION(:,:), ALLOCATABLE :: Parameters

!several parameters that are needed on runtime over several subroutines/functions

    INTEGER                             :: iip_length       !lengt of array iip for each particle

!parameters in input file (with default  values)


    INTEGER                             :: dl = 0           !output level for debuging
    INTEGER                             :: npar_global      !total number of particles
    INTEGER                             :: par_species=3    !number of different particle species
    INTEGER                             :: nt=10            !number of time steps
    INTEGER                             :: ndiag=1          !number of steps after which diagnose is done
    REAL(8)                             :: dt=1             !time stepsize (might have to be updated on runtime)
    REAL(8)                             :: t                !absolute time during run

    REAL(8)                             :: L=5              !size of Box in units of Particle 1 
    REAL(8), DIMENSION(:,:),ALLOCATABLE :: eps              !parameters for Lennard Jones interaction (symmetric)
    REAL(8), DIMENSION(:), ALLOCATABLE  :: cgamma           !damping constant for particles
    REAL(8)                             :: kt               !Kb*T thermal Energy of the system
    REAL(8)                             :: pi=3.14159265359

    NAMELIST /PARAMETER/ par_species, nt, ndiag, dt, L, kt

!variables for statistical evaluation

    REAL(8), DIMENSION(:), ALLOCATABLE  :: Edr      !mean square displacement of ensemble
    REAL(8), DIMENSION(:,:), ALLOCATABLE:: dr       !displacement for each particle

!parameters for file input/output

    INTEGER, PARAMETER  :: Edrout       = 20
    INTEGER, PARAMETER  :: energyout    = 21
    INTEGER, PARAMETER  :: trajectoryout= 22
    INTEGER, PARAMETER  :: histogramout = 23
CONTAINS

!==========================================================

    SUBROUTINE init_global

        INTEGER, PARAMETER  :: input=11
        INTEGER             :: i
        LOGICAL             :: existing
!----------------------------------------------------------
!initialize random numbers generator

!        CALL INIT_RANDOM_SEED()    !initialize according to system clock
        CALL RANDOM_SEED()          !initialize to default state

!----------------------------------------------------------
!Setting and loading main parameters for the calculation

        OPEN(unit=input, file="CSBD.in")
        READ(input,PARAMETER)
        CLOSE(input)
!----------------------------------------------------------
!Checking for Particle and Interaction parameters.
!Loading if available, else setting default values

!Properties for particle species

        INQUIRE(file='ParticleParameters.in', exist=existing)
        ALLOCATE(Parameters(1:nParameters,1:par_species))
        
        IF(existing .EQV. .FALSE.) THEN
            Parameters = 1 !default values for partricle numbers
        ELSEIF(existing .EQV. .TRUE.) THEN
            OPEN(unit=input, file='ParticleParameters.in', status='old', action='read')
            READ(input,*)
            DO i = 1,nParameters
            READ(input,*) Parameters(i,1:par_species)
            ENDDO
            CLOSE(input)
        ENDIF

print*, Parameters(D,1:par_species)

!calculate total number of particles

        npar_global = SUM(Parameters(pnumber,1:par_species))

        PRINT*, npar_global
        PRINT*, (Parameters(pnumber,1:par_species))

!epsilon for lennard jones

        INQUIRE(file='sigma.in', exist=existing)
        ALLOCATE(eps(1:par_species,1:par_species))

        IF(existing .EQV. .FALSE.) THEN
            eps = reshape((/ 1.0, 1.0, 1.0, 1.0, 0.1, 0.1, 1.0, 0.1, 0.1 /), shape(eps))     
        ELSEIF(existing .EQV. .TRUE.) THEN
            OPEN(unit=input, file='epsilon.in', status='old', action='read')
            READ(input,*)
            READ(input,*) eps
            CLOSE(input)
        ENDIF

        ALLOCATE(force(1:3,1:npar_global))

    END SUBROUTINE init_global

!----------------------------------------------------------
!Subroutine for initialisation of random numbers generator

    SUBROUTINE init_random_seed()
        INTEGER :: i, n, clock
        INTEGER, DIMENSION(:), ALLOCATABLE :: seed
        
        CALL RANDOM_SEED(size = n)
        ALLOCATE(seed(n))
        
        CALL SYSTEM_CLOCK(COUNT=clock)
        
        seed = clock + 37 * (/ (i - 1, i = 1, n) /)
        CALL RANDOM_SEED(PUT = seed)
        
        DEALLOCATE(seed)
    END SUBROUTINE
 

END MODULE global
