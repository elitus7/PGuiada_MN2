program jacobi
    implicit none

    REAL :: T0(101) ! T inicial (Tc a tot arreu)
    REAL :: Tm(101) ! Tn-1
    ! REAL :: Tn(101) ! Tn
    REAL :: B(101,101) ! Matriu de 1, -2, 1
    REAL :: Id(101,101) ! Matriu identitat
    REAL :: A(101,101) ! Matriu que multiplica Tn
    REAL :: D(101,101) ! diagonal de A
    REAL :: E(101,101) ! triangle superior de A
    REAL :: F(101,101) ! triangle inferior de B
    REAL, parameter :: Tc = 309.65/674! valor normalitzat de la temperatura a les fronteres
    REAL, parameter :: pas_x = 0.01
    REAL, parameter :: pas_t = pas_x
    INTEGER :: i,j

    DO i = 1,101
        T0(i) = Tc 
    END DO
    T0 = Tm
    DO i = 2,100
        Tm(i) = Tm(i) + pas_t
    END DO
    ! Definim la part dreta de la igualtat
    DO i = 2,100
        B(i,i-1) = 1 * ((pas_t)/(pas_x)**2)
        B(i,i) = -2 * ((pas_t)/(pas_x)**2)
        B(i,i+1) = 1 * ((pas_t)/(pas_x)**2)
    END DO
    DO i = 1,101
        B(1,i) = 0
        B(101,i) = 0
    END DO
    A = Id - B
    ! Definim la part esquerra de la igualtat, tenim una forma de Ax=B

    DO i = 1,101
        DO j = 1,101
            IF (i == j) THEN
                D(i,j) = A(i,j)
            ELSE
                D(i,j) = 0
            END IF
        END DO
    END DO
    !Definim la matriu diagonal
    DO i = 1,101
        DO j = 1,101
            IF (i < j) THEN
                E(i,j) = A(i,j)
            ELSE
                E(i,j) = 0
            END IF
        END DO
    END DO
    !Definim la matriu diagonal superior
    DO i = 1,101
        DO j = 1,101
            IF (i > j) THEN
                F(i,j) = A(i,j)
            ELSE
                F(i,j) = 0
            END IF
        END DO 
    END DO
    !Definim la matriu diagonal inferior
    WRITE(*,*) F

END program jacobi


    

