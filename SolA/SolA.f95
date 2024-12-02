program sola
    implicit none

    real, parameter :: pi = 3.1415926535897932384626433832795028842
    real, parameter :: e = 2.7182818284590452353602874713526624977
    real, parameter :: cv = 3686, p = 1081, k = 0.56, s = 0.472, pext = 944000, V = 40/(2**(0.5))
    real, parameter :: Tc = 36.5+273.15, T0 = (V**2*s)/k
    real, parameter :: Tc_norm = (36.5+273.15)/T0
    real, parameter :: t_norm = 0.025
    real, parameter :: z_ini = 0, z_f= 1, discr = 2/100
    real :: valor, valor_suma
    real :: z_norm
    integer, parameter :: n_max = int((z_f-z_ini)/discr) +1, m_max = int((z_f-z_ini)/discr) +1
    integer :: n, m
    real, dimension(n_max) :: valors_z
    real, dimension(n_max) :: valors_sol

    ! Document per guardar els resultats
    open(unit=10, file="resultats.dat", status="replace")

    ! Bucle per les z normalitzades
    do n = 1, n_max + 1
        z_norm = z_ini + (n-1)*discr
        valors_z(n) = z_norm

        valor_suma = 0.0

        ! Calculem el sumatori
        do m=1, m_max + 1

            valor = (4.0 / ((2.0 * m - 1.0) * pi)) * &
                    (1.0 - e**(-(2.0 * m - 1.0)**2 * pi**2 * t_norm)) * &
                    (1.0 / ((2.0 * m - 1.0)**2 * pi**2)) * &
                    sin((2.0 * m - 1.0) * pi * z_norm)
            
            valor_suma = valor_suma + valor

        end do

        valors_sol(n)= (Tc_norm + valor_suma)*T0-273.15 ! Desfem la normalització de T

    write(10,*) valors_z(n)* 2, valors_sol(n) ! Desfem la normalització de z

    end do

    call system("copy resultats.dat C:\\Users\\juuns\\Documents\\GitHub\\PGuiada_MN2\\error")

end program sola