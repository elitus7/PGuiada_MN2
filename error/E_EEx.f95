program error_eex
    implicit none

    integer, parameter :: n_max = 1000
    real :: x1, y1, x2, y2, resultat
    integer :: i, n, j
    real :: c1(n_max), c2(n_max), c_error(n_max)

    open(unit=10, file="eulex_results_f_g025.dat", status="old")
    open(unit=10, file="resultats.dat", status="old")
    open(unit=10, file="E_Eex.dat", status="replace")

    
    
       
    close(10)
    close(10)
    close(10)

end program error_eex
