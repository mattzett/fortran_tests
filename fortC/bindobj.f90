subroutine bindobj(ptr_alloc,lx,ly) bind(c)
  use datamod, only: testdata
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr
  type(c_ptr), intent(inout) :: ptr_alloc
  integer, intent(inout) :: lx,ly
  real(8), dimension(3,5) :: numbers

  ! initialize some test data
  numbers(1:3,1:5)=reshape([15,14,13,12,11,10,9,8,7,6,5,4,3,2,1],[3,5])
  call testdata%set_data(numbers)

  ! bind pointers to C
  ptr_alloc=c_loc(testdata%dataval)

  ! set sizes so C knows how large this data block is...
  lx=testdata%lx
  ly=testdata%ly
end subroutine bindobj
