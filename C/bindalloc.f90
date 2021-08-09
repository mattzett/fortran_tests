subroutine bindalloc(ptr_alloc) bind(c)
  use datamod
  use iso_c_binding, only: c_loc
  type(c_ptr), intent(inout) :: ptr_alloc

  allocate(dataalloc(lx,ly))
  ptr_alloc=c_loc(dataalloc)
end subroutine bindalloc
