!> Solving free-fall motion
program example_srkf45_mechanics

    use rkf45_module, only: srkf45, rk
    implicit none

    integer, parameter :: neqn = 2
    real(rk) :: t, y(neqn)
    real(rk) :: relerr = epsilon(1.0), abserr = epsilon(1.0), work(3 + 6*neqn)
    integer :: istat = 1, iwork(5)
    real(rk) :: t_start = 0.0_rk, t_end = 1.0_rk, dt = 0.2_rk

    print "(A/)", "srkf45: solving free-fall motion"
    print "(A6, *(A11))", "T", "Y", "Y_Exact", "Error", "V", "V_Exact", "Error"

    y(1) = 1.0
    y(2) = 0.0

    t = t_start
    do while(t < t_end)
        call srkf45(fcn, neqn, y, t, dt, 1, relerr, abserr, iwork, work, istat)
        associate (f => fx(t))
            print "(F6.2, 9(1x,ES10.3))", t, y(1), f(1), y(1) - f(1), y(2), f(2), y(2) - f(2)
        end associate
    end do

contains

    !> Evaluates the derivative for the ODE
    subroutine fcn(t, y, yp)
        real(rk), intent(in) :: t
        real(rk), intent(in) :: y(:)
        real(rk), intent(out) :: yp(:)

        yp(1) = y(2)
        yp(2) = -9.81_rk

    end subroutine fcn

    !> Exact solution
    function fx(t)
        real(rk), intent(in) :: t
        real(rk) :: fx(2)

        fx(1) = 1.0_rk - 0.5_rk*9.81_rk*t**2
        fx(2) = -9.81_rk*t

    end function fx

end program example_srkf45_mechanics
!> srkf45: solving free-fall motion
!> 
!>      T          Y    Y_Exact      Error          V    V_Exact      Error
!>   0.20  8.038E-01  8.038E-01  0.000E+00 -1.962E+00 -1.962E+00  1.192E-07
!>   0.40  2.152E-01  2.152E-01  0.000E+00 -3.924E+00 -3.924E+00  0.000E+00
!>   0.60 -7.658E-01 -7.658E-01 -2.980E-07 -5.886E+00 -5.886E+00  0.000E+00
!>   0.80 -2.139E+00 -2.139E+00  0.000E+00 -7.848E+00 -7.848E+00  0.000E+00
!>   1.00 -3.905E+00 -3.905E+00 -4.768E-07 -9.810E+00 -9.810E+00  0.000E+00
