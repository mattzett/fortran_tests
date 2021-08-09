subroutine bindstatic(ptr_static)
  use datamod
  use iso_c_binding, only: c_loc
  type(c_ptr), intent(inout) :: ptr_static

  datastatic(:,:)=1.0
  ptr_static=c_loc(datastatic)
end subroutine bindstatic
