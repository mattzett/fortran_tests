module datamod

implicit none (type, external)
public

! define different types of module variables, we make pointers to these so don't use bind(c)
integer, target :: lx=3, ly=5
real(8), dimension(3,5), target :: datastatic
real(8), dimension(:,:), pointer :: datapointer
real(8), dimension(:,:), allocatable, target :: dataalloc

! derived type containing data and procedures
type :: dataobj
  real(8), dimension(:,:), pointer :: dataval
  contains
    procedure :: set_data
    procedure :: print_data
end type dataobj

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! type-bound procedures
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

subroutine set_data(self,array)
  class(dataobj), intent(inout) :: self
  real(8), dimension(:,:), intent(in) :: array

  allocate(self%dataval(size(array,1),size(array,2)))
  self%dataval(:,:)=array(:,:)
end subroutine set_data

subroutine print_data(self)
  class(dataobj), intent(inout) :: self

  print*, self%dataval(:,:)
end subroutine print_data

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! module procedures
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine print_data_rows(array,lx,ly) bind(c)    ! note we cannot bind to C with assumed shape arguments, sizes must be input
  real(8), dimension(lx,ly), intent(in) :: array
  integer, intent(in) :: lx,ly
  integer :: i

  print*, '  printing array from fortran:  '
  print*, '  input sizes:  ',lx,ly
  do i=1,lx
    print*, array(i,1:ly)
  end do
end subroutine print_data_rows

end module datamod

