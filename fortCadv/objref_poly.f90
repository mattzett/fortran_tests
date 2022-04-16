!> This binds an array that is incapsulated in a fortran type to a C pointer
subroutine objref(cptr_f90obj,lx,ly) bind(c)
  use datamod, only: dataobj
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr,c_f_pointer

  type(dataobj), pointer :: obj
  type(dataobj), pointer :: objconvert
  type(c_ptr), intent(inout) :: cptr_f90obj
  integer, intent(inout) :: lx,ly
  real(8), dimension(3,5) :: numbers

  ! allocation derived type
  allocate(obj)
  allocate(objconvert)

  ! initialize some test data
  print*, 'Initializing test data...'
  numbers(1:3,1:5)=reshape([15,14,13,12,11,10,9,8,7,6,5,4,3,2,1],[3,5])
  call obj%set_data(numbers)
  call obj%print_data()

  ! bind pointers to C
  print*, 'Getting a C pointer to data object'
  cptr_f90obj=c_loc(obj)
  print*, cptr_f90obj

  print*, 'Convert C pointer to fortran pointer'
  call c_f_pointer(cptr_f90obj,objconvert)
  print*, 'Size of object data:  ',objconvert%lx,objconvert%ly
  print*, 'Invoke print method on converted object'
  call objconvert%print_data()

  ! set sizes so C knows how large this data block is...
  lx=obj%lx
  ly=obj%ly
end subroutine objref
