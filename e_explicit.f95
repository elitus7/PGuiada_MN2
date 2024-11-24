!Programa per la implementació del mètode d'euler explícit.
program e_explicit
    implicit none(type, external)
    !Definim els punts del mallat espacial i la seva amplada. Definim també l'amplada del mallat temporal.
    real, parameter :: Nz = 101, Deltax = 2
    real, parameter :: Deltat = 0.025
    !Definim condicions inicials i de frontera. j fa referència al punt del mallat espacial, n fa referència al punt del mallat temporal.
    real, parameter :: T_0j = 36.5, T_n0 = 36.5, T_n101 = 36.5 
    !Definim la relació entre les amplades dels mallats espacial i temporal. 
    real :: lambda
    integer :: Nt
    
    !Cálcul del nombre de punts del mallat temporal.
    lambda = 0.51
    call calculNt(Deltat, lambda, Nt)
    write(*,*) Nt



contains
    subroutine calculNt(Deltat, lambda, Nt)
        !Arguments 
        real, intent(in) :: Deltat
        real, intent(in) :: lambda
        integer, intent(out) :: Nt
        Nt = ceiling(Deltat / ((real(Deltax)/real(Nz))**2 * lambda))
    end subroutine

end program e_explicit