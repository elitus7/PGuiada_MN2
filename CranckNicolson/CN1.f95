program CN1
    implicit none

    REAL :: T0(101) ! T inicial a cada punt de l'espai
    REAL :: Tm(101) ! Tn-1 a cada punt de l'espai
    REAL :: Tn(101) ! Tn a cada punt de l'espai
    real :: TT(101) 
    REAL :: B(101,101) ! Matriu de 1, -2, 1
    REAL :: Id(101,101) ! Matriu identitat
    REAL :: A(101,101) ! Matriu que multiplica Tn+1
    REAL :: A1(101,101) ! Matriu que multiplica Tn
    REAL :: D(101,101) ! diagonal de A
    REAL :: E(101,101) ! triangle superior de A
    REAL :: F(101,101) ! triangle inferior de A
    REAL :: Dinv(101,101) ! inversa de D 
    REAL, parameter :: Tc = 309.65/674 !valor normalitzat de la temperatura a les fronteres
    REAL, parameter :: pas_x = 0.01 !valor de cada dx
    REAL, parameter :: pas_t = pas_x !valor de cada dt
    real, parameter :: gamma = ((pas_t)/((pas_x)**2))
    INTEGER :: j,i,k,l,p,o,m,n,h,y,t,r,u,s !integers utilitzats per fer bucles

    ! Definim la temperatura inicial amb Tc a tots els punts de l'espai
    T0 = Tc
    
    do i = 2,100
        TT(i) = pas_t
    end do

    ! Definim matriu B (A i A1 les conté)
    DO s = 2,100
        B(s,s-1) = 1 * gamma
        B(s,s) = -2 * gamma
        B(s,s+1) = 1 * gamma
    END DO
    DO u = 1,101
        B(1,u) = 0
        B(101,u) = 0
    END DO

    ! Matriu identitat
    DO r = 1,101
        DO t = 1,101
            Id(r,t) = 0
        END DO
    END DO
    DO y = 1,101
        Id(y,y) = 1
    END DO
    
    ! Matriu A (multiplica Tn) i matriu A1 (multiplica Tm)
    A = Id - B/2
    A1 = Id + B/2

    !Definim la matriu diagonal d'A
    DO h = 1,101
        DO n = 1,101
            IF (h == n) THEN
                D(h,n) = A(h,n)
            ELSE
                D(h,n) = 0
            END IF
        END DO
    END DO
    
    !Definim la matriu diagonal inferior
    DO m = 1,101
        DO o = 1,101
            IF (o < m) THEN
                E(m,o) = A(m,o)
            ELSE
                E(m,o) = 0
            END IF
        END DO
    END DO

    !Definim la matriu diagonal superior
    DO p = 1,101
        DO l = 1,101
            IF (l > p) THEN
                F(p,l) = A(p,l)
            ELSE
                F(p,l) = 0
            END IF
        END DO 
    END DO

    !Definim la inversa de la diagonal
    DO k = 1,101
        Dinv(k,k) = 1/D(k,k)
    END DO
    
    
    Tm = T0
    DO i = 1,3 ! 3 pases per arribar a t = 0.030 (no podem fer mitja passa, hem de superar t = 0.025)
        ! Apliquem  el metode del Jacobi amb 10000 iteracions
        DO j = 1,10000
            do k = 2,100 
                Tn = MATMUL(-Dinv,MATMUL((E+F),Tn)) + MATMUL(Dinv,MATMUL(A1,Tm)+TT)
            end do
        END DO
        Tm = Tn 
    END DO
    !Hem aplicat el metode de Crank-Nicolson

    ! Guardem dades i creem gràfica
    OPEN(unit=10, file="Temperatura_CN1.dat", status="replace")
        DO i = 1, 101
            WRITE(10,*) Tn(i)*674 - 273.15
        END DO
        !Creem un arxiu .dat on guardem els valors de Tn desnormalitzats

    OPEN(unit=10, file="Temps_CN1.dat", status="replace")
        DO i = 1,3
            WRITE(10,*) (0.02/100)*(i-1)
        END DO

        !Creem un arxiu .dat que generi els diferents valors del temps
    OPEN(unit=10, file="Resultats_CN1.dat", status="replace")
        DO i = 1, 101
            WRITE(10,*) (Tn(i)*674 - 273.15), ((0.02)*(i-1))
        END DO

END program CN1