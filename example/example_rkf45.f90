!> Solve a Bernoulli differential equation using rkf45:
!> y' = y - 2*x/y
program example_rkf45

    use rkf45_module, only: rkf45, rk

    integer, parameter :: neqn = 1
    real(rk) :: t = 0.0_rk, t_out = 0.0_rk, y(neqn)
    real(rk) :: relerr = epsilon(1.0), abserr = epsilon(1.0)
    integer :: flag = 1
    integer :: iwork(5), i, n_step = 5
    real(rk) :: work(3 + 6*neqn)
    real(rk) :: t_start = 0.0_rk, t_end = 1.0_rk

    print "(A/)", "rkf45: solve a Bernoulli differential equation, y' = y - 2*x/y"
    print "(A6, *(A18))", "T", "Y", "Y_Exact", "Error"

    y = 1.0
    do i = 1, n_step

        t = t_start + (i - 1)*(t_end - t_start)/n_step
        t_out = t_start + i*(t_end - t_start)/n_step
        call rkf45(fcn, neqn, y, t, t_out, relerr, abserr, flag, work, iwork)

        print "(F6.2, 3ES18.10)", t, y(1), fx(t), fx(t) - y(1)

    end do

contains

    !> Evaluates the derivative for the ODE
    subroutine fcn(t, y, yp)
        real(rk), intent(in) :: t
        real(rk), intent(in) :: y(:)
        real(rk), intent(out) :: yp(:)

        yp(1) = y(1) - 2.0_rk*t/y(1)

    end subroutine fcn

    !> Exact solution
    real(rk) function fx(t)
        real(rk), intent(in) :: t

        fx = sqrt(1.0_rk + 2.0_rk*t)

    end function fx

end program example_rkf45
!> rkf45: solve a Bernoulli differential equation, y' = y - 2*x/y
!> 
!>      T                 Y           Y_Exact             Error
!>   0.20  1.1832159758E+00  1.1832159758E+00  0.0000000000E+00
!>   0.40  1.3416407108E+00  1.3416407108E+00  0.0000000000E+00
!>   0.60  1.4832396507E+00  1.4832397699E+00  1.1920928955E-07
!>   0.80  1.6124514341E+00  1.6124515533E+00  1.1920928955E-07
!>   1.00  1.7320506573E+00  1.7320507765E+00  1.1920928955E-07
