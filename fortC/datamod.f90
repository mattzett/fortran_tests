module datamod

implicit none (type, external)
public

! derived type definition containing data and procedures
type :: dataobj
  real(8), dimension(:,:), pointer :: dataval
  integer :: lx,ly
  contains
    procedure :: set_data
    procedure :: print_data
    final :: destructor
end type dataobj

! define different types of module variables, we make pointers to these so don't use bind(c)
integer, target :: lx=3, ly=5
real(8), dimension(3,5), target :: datastatic
real(8), dimension(:,:), pointer :: datapointer
real(8), dimension(:,:), allocatable, target :: dataalloc
type(dataobj) :: testdata

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! type-bound procedures
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

subroutine set_data(self,array)
  class(dataobj), intent(inout) :: self
  real(8), dimension(:,:), intent(in) :: array

  self%lx=size(array,1)
  self%ly=size(array,2)
  allocate(self%dataval(self%lx,self%ly))
  self%dataval(:,:)=array(:,:)
end subroutine set_data

subroutine print_data(self)
  class(dataobj), intent(inout) :: self

  print*, 'Stored data:  '
  print*, self%dataval(:,:)
end subroutine print_data

subroutine destructor(self)
  type(dataobj), intent(inout) :: self

  print*, '  dataobj destructor triggered (object going out of scope)!'
  deallocate(self%dataval)
  self%lx=0; self%ly=0;
end subroutine destructor

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

