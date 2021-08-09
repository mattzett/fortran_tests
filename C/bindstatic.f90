subroutine bindstatic(ptr_static,ptr_lx,ptr_ly) bind(c)
  use datamod
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr
  
  type(c_ptr), intent(inout) :: ptr_static,ptr_lx,ptr_ly

  datastatic(1:lx,1:ly)=reshape([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],[lx,ly])
  print*, '  print static array after assignment:  '
  call print_data_rows(datastatic)
  ptr_static=c_loc(datastatic)
  ptr_lx=c_loc(lx)
  ptr_ly=c_loc(ly)
end subroutine bindstatic
