module datamod

implicit none (type, external)
public

! define different types of module variables, we make pointers to these so don't use bind(c)
integer, parameter :: lx=10, ly=10
real(8), dimension(lx,ly), target :: datastatic
real(8), dimension(:,:), pointer :: datapointer
real(8), dimension(:,:), allocatable :: dataalloc

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

  allocate(self%dataval(size(array,1),size(array,2))
  self%dataval(:,:)=array(:,:)
end subroutine set_data

subroutine print_data(self)
  class(dataobj), intent(inout) :: self

  print*, self%dataval(:,:)
end subroutine print_data

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! module procedures
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine print_data_rows(array)
  real(wp), dimension(:,:), intent(in) :: array
  integer :: i

  do i=1,size(array,1)
    print*, array(i,:)
  end do
end subroutine print_data_rows

end module datamod

