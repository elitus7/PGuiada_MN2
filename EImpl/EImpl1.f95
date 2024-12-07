program eulerimp1
    implicit none

    REAL :: T0(101) ! T inicial a cada punt de l'espai
    REAL :: Tm(101) ! Tn-1 a cada punt de l'espai
    REAL :: Tn(101) ! Tn a cada punt de l'espai
    REAL :: B(101,101) ! Matriu de 1, -2, 1
    REAL :: Id(101,101) ! Matriu identitat
    REAL :: A(101,101) ! Matriu que multiplica Tn
    REAL :: D(101,101) ! diagonal de A
    REAL :: E(101,101) ! triangle superior de A
    REAL :: F(101,101) ! triangle inferior de B
    REAL :: Dinv(101,101) ! inversa de D
    REAL, parameter :: Tc = 309.65/674 !valor normalitzat de la temperatura a les fronteres
    REAL, parameter :: pas_x = 0.01 !valor de cada dx
    REAL, parameter :: pas_t = pas_x !valor de cada dt
    INTEGER :: j,i,k,l,p,o,m,n,h,y,t,r,u,s,x !integers utilitzats per fer bucles

    DO j = 1,101
        T0(j) = Tc 
    END DO
    !Definim la temperatura inicial amb Tc a tots els punts de l'espai
    DO s = 2,100
        B(s,s-1) = 1 * ((pas_t)/((pas_x)**2))
        B(s,s) = -2 * ((pas_t)/((pas_x)**2))
        B(s,s+1) = 1 * ((pas_t)/((pas_x)**2))
    END DO
    DO u = 1,101
        B(1,u) = 0
        B(101,u) = 0
    END DO
    DO r = 1,101
        DO t = 1,101
            Id(r,t) = 0
        END DO
    END DO
    DO y = 1,101
        Id(y,y) = 1
    END DO
    A = Id - B
    ! Definim la part esquerra de la igualtat, tenim una forma de Ax= Tm + pas_t
    DO h = 1,101
        DO n = 1,101
            IF (h == n) THEN
                D(h,n) = A(h,n)
            ELSE
                D(h,n) = 0
            END IF
        END DO
    END DO
    !Definim la matriu diagonal
    DO m = 1,101
        DO o = 1,101
            IF (o < m) THEN
                E(m,o) = A(m,o)
            ELSE
                E(m,o) = 0
            END IF
        END DO
    END DO
    !Definim la matriu diagonal inferior
    DO p = 1,101
        DO l = 1,101
            IF (l > p) THEN
                F(p,l) = A(p,l)
            ELSE
                F(p,l) = 0
            END IF
        END DO 
    END DO
    !Definim la matriu diagonal superior
    DO k = 1,101
        Dinv(k,k) = 1/D(k,k)
    END DO
    !Definim la inversa de la diagonal
    Tm = T0
    DO i = 1,3 !fem tres pases per arribar a t=0.030 (per sobre de 0.025)
        DO x = 2,100
            Tm(x) = Tm(x) + pas_t
        END DO
        !Definim la part B d'un sistema tipus Ax = B
        !Fem que la suposició inicial x_0 sigui tota 0
        DO j = 1,10000
            Tn = MATMUL(-Dinv,MATMUL((E+F),Tn)) + MATMUL(Dinv,Tm)
        END DO
        ! Apliquem  el metode del Jacobi amb 10000 iteracions
        Tm = Tn 
    END DO
    !Hem aplicat el metode de Euler implicit
    OPEN(unit=10, file="Temperatura_Eulimp_1.dat", status="replace")
        DO i = 1, 101
            WRITE(10,*) Tn(i)*674 - 273.15
        END DO
        !Creem un arxiu .dat on guardem els valors de Tn desnormalitzats
    OPEN(unit=10, file="Posicio_Eulimp.dat", status="replace")
        DO i = 1,101
            WRITE(10,*) (0.02/100)*(i-1)
        END DO
        !Creem un arxiu .dat que generi els diferents valors de x
    OPEN(unit=10, file="Temps_Eulimp_1.dat", status="replace")
        DO i = 1,3
            WRITE(10,*) (0.02/100)*(i-1)
        END DO
        !Creem un arxiu .dat que generi els diferents valors del temps
    OPEN(unit=10, file="Resultats_Eulimp_1.dat", status="replace")
        DO i = 1, 101
            WRITE(10,*) (Tn(i)*674 - 273.15), ((0.02/100)*(i-1))
        END DO

    call system("copy Resultats_Eulimp_1.dat C:\\Users\\juuns\\Documents\\GitHub\\PGuiada_MN2\\error")

END program eulerimp1



    

