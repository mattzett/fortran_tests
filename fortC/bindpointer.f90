subroutine bindpointer(ptr_pointer) bind(C)
  use datamod
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr
  type(c_ptr), intent(inout) :: ptr_pointer

  allocate(datapointer(lx,ly))
  ptr_pointer=c_loc(datapointer)
end subroutine bindpointer
