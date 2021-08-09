subroutine bindstatic(ptr_static,ptr_lx,ptr_ly) bind(c)
  use datamod
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr
  
  type(c_ptr), intent(inout) :: ptr_static,ptr_lx,ptr_ly

  datastatic(1:lx,1:ly)=1.0
  ptr_static=c_loc(datastatic)
  ptr_lx=c_loc(lx)
  ptr_ly=c_loc(ly)
end subroutine bindstatic
