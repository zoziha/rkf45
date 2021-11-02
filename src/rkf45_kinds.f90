module rkf45_kinds

    !> REAL32: Single Precision
    !> REAL64: Double Precision
    
    use, intrinsic :: iso_fortran_env, only: real32, real64
    implicit none
    private
    
    public :: rk
    
    !> REAL Precision
    integer, parameter :: rk = real32

end module rkf45_kinds