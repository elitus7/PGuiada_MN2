!Programa per la implementació del mètode d'euler explícit. Resoldrem l'equació NORMALITZADA. Al final desnormalitzem.
program e_explicit
    implicit none(type, external)

    real, parameter :: cv = 3686, p = 1081, k = 0.56, s = 0.472, pext = 944000, Veff = 40 / ((2)**(0.5)) !Constant físiques necessàries.
    real, parameter :: znorm = 0.02 !Factor de normalització espacial.
    real :: tnorm = ((znorm**2)*cv*p)/k !Factor de normalització temporal.
    real :: T_norm =  ((Veff**2) * s)/k !Factor de normalització de la temperatura en graus Kelvin.
    integer :: n, j !Índexs que usarem per iterar. n serà l'índex temporal i j serà l'índex espacial.
    integer, parameter :: Nz = 101 !Nombre de punts del mallat espacial.
    integer, parameter :: Ntmax = 30000 !Nombre de punts màxim del mallat espacial (em feia falta definir-ho perquè per treballar amb matrius les dimensions han de ser "paramter"...).
    integer :: Nt !Nombre de punts del mallat temporal.
    real, parameter :: z0 = 0, zf = 1 !Interval espacial normalitzat.
    real, parameter :: t0 = 0, tf = 0.025 !Interval temporal normalitzat.
    real, parameter :: T_0 = (36.5+273.15) !Condició inicial i de contorn de temperatura.
    real :: gamma !Relació entre les amplades del mallat espacial i el mallat temporal.
    real :: T(nz), T_new(nz) !Vectors de temperatura que usarem en el bucle.
    real :: T_results(Nz, Ntmax) !Array que usem per guardar tot el conjunt de resultats. Caldrà assegurar-nos de què Nt no excedeix Ntmax!
    real :: Deltat, Deltaz !Amplades del mallat temporal i del mallat espacial.
    real :: t_real(Ntmax)
    real :: z_real(Nz)
    write(*,*) tnorm
    write(*,*) T_norm
    !Cálcul del nombre de punts del mallat temporal. Usant la subrutina calculNt.
    gamma = 0.25
    call calculNt(tf, gamma, Nt)

    Deltat = tf / Nt !Assignem el valor del mallat temporal normalitzat.
    Deltaz = real(zf) / (Nz-1) !Assignem el valor del mallat espacial.
    print *, "Amplada mallat temporal normalitzat: ",Deltat

    write(*,*) "Nombre de punts del mallat temporal normalitzat :", Nt
    write(*,*) "Nombre de punts del mallat espacial normalitzat :", Nz
    if (Nt > Ntmax) then !Comprovem que el mallat temporal no és més gran del màxim permès.
        write(*,*) "T'has passat amb el mallat temporal, fes-lo mes petit o dona un Ntmax major!"
        stop
    end if

    !Inicialitzem els valors de temperatura i els normalitzem amb el factor de normalització per a la temperatura. La temperatura inicial és en tots els punts T0.
    T = T_0/T_norm
    T_new = T_0/T_norm

    T_results(:,1) = T !Guardem aquesta informació. La primera columna es correspondrà amb els valors de T en tots els punts de l'espai per a temps inicial.
    !Primer apliquem les condicions de contorn, de forma que la temperatura al primer punt i al darrer siguin T0.
    T_new(1) = T_0/T_norm !Per z inicial.
    T_new(Nz) = T_0/T_norm !Per z final.

    !Bucle que ens donarà la matriu resultat, és a dir, el vector de temperatures.
    do n = 1, Nt
        !Ara fem la iteració per tots els punts de l'espai, donat un temps.
        do j = 2, Nz-1
        T_new(j) = gamma*(T(j+1)-2*T(j)+T(j-1)) + T(j) + Deltat
        end do

        !Actualitzem el vector de temperatures.
        T = T_new

        !Guardem la nova informació aconseguida a la següent columna del nostre array de resultats.
        T_results(:,n+1) = T
    end do
!write(*,*) size(T) !Naturalment és 101, la quantitat de punts del mallat espacial
write (*,*) "Temperatura normalitzada a les fronteres: ", T_new(1), "/", T_new(Nz)

!Desnormalitzem i guardem en un arxiu. Per desnormalitzar només cal multiplicar la variable normalitzada pel corresponent factor de normalització.

do j = 1, Nz
    z_real(j) = (j-1)*Deltaz*znorm
end do

open(unit=10, file="eulex_results.dat", status="replace")
    do n = 1, Nt
        t_real(n) = (n-1)*Deltat*tnorm
        write(10, *) (T_results(j, n)*T_norm - 273.15, j = 1, Nz) !Cada columna fa referència a una posició i cada fila a un instant de temps.
    end do
close(10)
write(*,*) "========================="
write(*,*) "Els resultats es poden veure a l'arxiu 'eulex_results.dat'."

open(unit=10, file="posicions_z.dat", status="replace")
    do n = 1, Nz
        write(10,*) z_real(n)
    end do
close(10)

open(unit=10, file="temps_t.dat", status="replace")
    do j = 1, Nt
        write(10,*) t_real(j)
    end do
close(10)

!Subrutina que ens permet calcular el nombre de punts del mallat temporal en funció del problema.
contains
    subroutine calculNt(tf, gamma, Nt)
        !Arguments.
        real, intent(in) :: tf
        real, intent(in) :: gamma
        integer, intent(out) :: Nt
        Nt = ceiling(tf / ((real(zf)/real(Nz))**2 * gamma))
    end subroutine

end program e_explicit