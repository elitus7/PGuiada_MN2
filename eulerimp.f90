program eulerimp
    implicit none
    REAL :: T0(102)
    REAL :: Tn(102)
    REAL :: Tm(102)
    REAL :: Tc
    Tc = 309.65
    DO j = 1,102
        T0(j) = Tc 
    END DO
    Tm = T0
    DO j = 1,102


