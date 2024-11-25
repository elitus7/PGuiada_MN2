!Programa per la implementació del mètode d'euler explícit.
program e_explicit
    implicit none(type, external)

    integer :: n, j !Índexs que usarem per iterar. n serà l'índex temporal i j serà l'índex espacial.
    integer, parameter :: Nz = 101 !Nombre de punts del mallat espacial.
    integer, parameter :: Ntmax = 300 !Nombre de punts màxim del mallat espacial (em feia falta definir-ho perquè per treballar amb matrius les dimensions han de ser "paramter"...).
    integer :: Nt !Nombre de punts del mallat temporal.
    real, parameter :: z0 = 0, zf = 2 !Interval espacial.
    real, parameter :: t0 = 0, tf = 0.025 !Interval temporal.
    real, parameter :: T_0 = 36.5  !Condició inicial i de contorn.
    real :: gamma !Relació entre les amplades del mallat espacial i el mallat temporal.
    real :: T(nz), T_new(nz) !Vectors de temperatura que usarem en el bucle.
    real :: T_results(Nz, Ntmax) !Array que usem per guardar tot el conjunt de resultats. Caldrà assegurar-nos de què Nt no excedeix Ntmax!
    real :: Deltat, Deltaz !Amplades del mallat temporal i del mallat espacial.
    integer :: i 

    !Cálcul del nombre de punts del mallat temporal. Usant la subrutina calculNt.
    gamma = 0.25
    call calculNt(tf, gamma, Nt)

    Deltat = tf / Nt !Assignem el valor del mallat temporal.
    Deltaz = real(zf) / Nz !Assignem el valor del mallat espacial.

    print *, Nt
    if (Nt > Ntmax) then !Comprovem que el mallat temporal no és més gran del màxim permès.
        write(*,*) "T'has passat amb el mallat temporal, fes-lo més petit o dóna un Ntmax major!"
        stop
    end if

    !Inicialitzem els valors de temperatura. La temperatura inicial és en tots els punts T0.
    T = T_0
    T_new = T_0
    print *, T_new(1)
    T_results(:,1) = T !Guardem aquesta informació. La primera columna es correspondrà amb els valors de T en tots els punts de l'espai per a temps inicial.
    print *, T(1)
    do n = 1, Nt
        !Primer apliquem les condicions de contorn, de forma que la temperatura al primer punt i al darrer siguin T0.
        T_new(1) = T_0 !Per z=0.
        T_new(Nz) = T_0 !Per z=2.
        
        !Ara fem la iteració per tots els punts de l'espai, donat un temps.
        do j = 1, Nz
        T_new(j) = gamma*(T(j+1)-2*T(j)+T(j-1)) + Deltat + T(j)
        end do

        !Actualitzem el vector de temperatures.
        T = T_new

        !Guardem la nova informació aconseguida a la següent columna del nostre array de resultats.
        T_results(:,n+1) = T
    end do
    print *, T_new(1)
!write(*,*) size(T) !Naturalment és 101, la quantitat de punts del mallat espacial

open(unit=10, file="eulex_results.dat", status="replace")
    do n = 1, nt+1
       write(10, *) (T_results(i, n), i = 1, nz)
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