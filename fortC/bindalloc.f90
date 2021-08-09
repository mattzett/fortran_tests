subroutine bindalloc(ptr_alloc) bind(c)
  use datamod
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr
  type(c_ptr), intent(inout) :: ptr_alloc

  allocate(dataalloc(lx,ly))
  dataalloc(:,:)=2.0
  ptr_alloc=c_loc(dataalloc)
end subroutine bindalloc
