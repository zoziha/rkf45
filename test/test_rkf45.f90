module test_rkf45

    use testdrive, only: new_unittest, unittest_type, error_type, check
    implicit none
    private

    public :: collect_rkf45

contains

    !> All tests for rkf45
    subroutine collect_rkf45(testsuite)

        type(unittest_type), allocatable, intent(out) :: testsuite(:)

        testsuite = [ &
                    new_unittest("rkf45", test_rkf45) &
                    ]

    end subroutine collect_rkf45

    !> Solve a Bernoulli differential equation using rkf45:
    !> y' = y - 2*x/y
    subroutine test_rkf45(error)

        use rkf45_module, only: rkf45, rk
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: neqn = 1
        real(rk) :: t = 0.0, t_out = 0.0, y(neqn)
        real(rk) :: relerr = epsilon(1.0), abserr = epsilon(1.0)
        integer :: flag = 1
        integer :: iwork(5), i, n_step = 5
        real(rk) :: work(3 + 6*neqn)
        real(rk) :: t_start = 0.0, t_end = 1.0

        y = 1.0
        do i = 1, n_step

            t = t_start + (i - 1)*(t_end - t_start)/n_step
            t_out = t_start + i*(t_end - t_start)/n_step
            call rkf45(fcn, neqn, y, t, t_out, relerr, abserr, flag, work, iwork)

            call check(error, abs(y(1) - fx(t)) <= 0.11921E-06)   !! 0.119209E-06
            if (allocated(error)) return

        end do

    contains

        !> Evaluates the derivative for the ODE
        subroutine fcn(t, y, yp)
            real(rk), intent(in) :: t
            real(rk), intent(in) :: y(:)
            real(rk), intent(out) :: yp(:)

            yp(1) = y(1) - 2*t/y(1)

        end subroutine fcn

        !> Exact solution
        real(rk) function fx(t)
            real(rk), intent(in) :: t

            fx = sqrt(1 + 2*t)

        end function fx

    end subroutine test_rkf45

end module test_rkf45
