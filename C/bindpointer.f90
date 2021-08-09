subroutine bindpointer(ptr_pointer) bind(C)
  use datamod
  use iso_c_binding, only: c_loc
  type(c_ptr), intent(inout) :: ptr_pointer

  allocate(datapointer(lx,ly))
  ptr_pointer=c_loc(datapointer)
end subroutine bindpointer
