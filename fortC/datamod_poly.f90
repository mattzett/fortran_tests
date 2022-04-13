module datamod_poly

implicit none (type, external)
public

! derived type definition containing data and procedures
type, abstract :: dataobj_poly
  real(8), dimension(:,:), pointer :: dataval
  integer :: lx,ly
  contains
    procedure :: set_data
    procedure :: print_data
!    final :: destructor
end type dataobj_poly

type, extends(dataobj_poly) :: data1
  integer :: datstat
end type data1

type, extends(dataobj_poly) :: data2
  real(8) :: datmag
end type data2
contains
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !! type-bound procedures
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  subroutine set_data(self,array)
    class(dataobj_poly), intent(inout) :: self
    real(8), dimension(:,:), intent(in) :: array
  
    self%lx=size(array,1)
    self%ly=size(array,2)
    allocate(self%dataval(self%lx,self%ly))
    self%dataval(:,:)=array(:,:)
  end subroutine set_data
  
  subroutine print_data(self)
    class(dataobj_poly), intent(inout) :: self
  
    print*, 'Stored data:  '
    print*, self%dataval(:,:)
  end subroutine print_data
  
!  subroutine destructor(self)
!    type(dataobj), intent(inout) :: self
!  
!    print*, '  dataobj destructor triggered (object going out of scope)!'
!    deallocate(self%dataval)
!    self%lx=0; self%ly=0;
!  end subroutine destructor
end module datamod_poly

