program e_im1
    implicit none

    integer, parameter :: nmax = 1000 !Valor gran, no ens interessa el nombre concret
    real :: col1a(nmax), col2a(nmax), col1b(nmax), col2b(nmax), col1out(nmax), col2out(nmax)
    integer :: n, m, i
    character(len=50) :: analit, eim, error

    ! Noms dels arxius
    analit = "resultats.dat"
    eim = "Resultats_Eulimp_1.dat"
    error = "Error_EIm_1.dat"

    ! Llegim el fitxer de la solució analítica
    open(unit=10, file=analit, status="old", action="read")
    n = 0
    do
        n = n + 1
        read(10, *, iostat=i) col1a(n), col2a(n)
        if (i /= 0) exit ! Condició de sortida
    end do
    n = n - 1
    close(10)

    ! Llegim el fitxer del mètode Euler Explícit
    open(unit=11, file=eim, status="old", action="read")
    m = 0
    do
        m = m + 1
        read(11, *, iostat=i) col1b(m), col2b(m)
        if (i /= 0) exit ! Condició de sortida
    end do
    m = m - 1
    close(11)

    
    do i = 1, n
        col1out(i) = col1a(i)  ! La primera columna són les z que tenen els mateixos valors a ambdós fitxers
        col2out(i) = col1b(i) - col2a(i)  ! Solució Analítica - Solució Euler Implícit
    end do

    ! Escrivim els resultats en un document .dat nou per poder graficar
    open(unit=12, file=error, status="replace", action="write")
    do i = 1, n
        write(12, '(F10.6, 1X, F10.6)') col1out(i), col2out(i)
    end do
    close(12)

end program e_im1