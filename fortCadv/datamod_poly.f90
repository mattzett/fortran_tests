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
  contains
    procedure :: print_data=>print_data1
end type data1

type, extends(dataobj_poly) :: data2
  real(8) :: datmag
  contains
    procedure :: print_data=>print_data2
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
  
  !> the default print is as a row vector
  subroutine print_data(self)
    class(dataobj_poly), intent(inout) :: self
  
    print*, 'Stored data:  '
    print*, self%dataval(:,:)
  end subroutine print_data

  !> objects of type1 will print out as a matrix on the console
  subroutine print_data1(self)
    class(data1), intent(inout) :: self
    integer :: ix

    print*, 'Stored data:  '
    do ix=1,self%lx
      print*, self%dataval(ix,:)
    end do
  end subroutine print_data1

  !> objects of type2 will print out as a column vector on the console
  subroutine print_data2(self)
    class(data2), intent(inout) :: self
    integer :: ix,iy

    print*, 'Stored data:  '
    do ix=1,self%lx
      do iy=1,self%ly
        print*, self%dataval(ix,iy)
      end do
    end do
  end subroutine print_data2
end module datamod_poly

