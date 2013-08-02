MODULE setup

    USE global
    
    IMPLICIT NONE

    CONTAINS

    SUBROUTINE spherical_sink(diameter,thickness,counter)

    REAL(8), INTENT(in)     :: diameter    !Diameter of the sink as fraction of L
    REAL(8), INTENT(in)     :: thickness   !Thickness of layer for particle displacement as fraction of L
    REAL(8)                 :: Rr   !Distance of Particle to sink
    REAL(8), DIMENSION(3)   :: R    !Position of the sink
    REAL(8), DIMENSION(3)   :: rd   !random displacement vector
    REAL(8), DIMENSION(4)   :: rand
    INTEGER, INTENT(out)    :: counter !counter for absorbed particles
    INTEGER                 :: i, j

    R = L/2.

    counter = 0
    DO i = 1,npar_global
        Rr = SQRT(DOT_PRODUCT(par(CX:CY,i)-R(1:2),par(CX:CY,i)-R(1:2)))
        IF(Rr < diameter*L) THEN
            WRITE(25, *) par(CX:CZ,i)
            counter = counter + 1
            CALL RANDOM_NUMBER(rand)
            rd(1) = (L/2. - thickness*rand(1))*COS(2*pi*rand(2))*SIN(pi*rand(3))
            rd(2) = (L/2. - thickness*rand(1))*SIN(2*pi*rand(2))*SIN(pi*rand(3))
            rd(3) = (L/2. - thickness*rand(1))*COS(pi*rand(3))
            par(CX:CY,i) = R(1:2) + rd(1:2)
            WRITE(26, *) par(CX:CZ,i)
            print*, sqrt(DOT_PRODUCT(rd,rd))-L/2.
        ENDIF
    ENDDO
    

    END SUBROUTINE spherical_sink


END MODULE setup
