program jacobi
    implicit none

    REAL :: T0(101) ! T inicial (Tc a tot arreu)
    REAL :: Tm(101) ! Tn-1
    REAL, parameter :: Tc = 309.65/674! valor normalitzat de la temperatura a les fronteres
    REAL, parameter :: pas_x = 0.01
    REAL, parameter :: pas_t = pas_x
    INTEGER :: i
    DO i = 1,101
        T0(i) = Tc 
    END DO
    T0 = Tm
    DO i = 2,100
        Tm(i) = Tm(i) + pas_t
    END DO
    
end program jacobi