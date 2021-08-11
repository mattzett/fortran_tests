subroutine bindpointer(ptr_pointer,ptr_lx,ptr_ly) bind(C)
  use datamod
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr
  type(c_ptr), intent(inout) :: ptr_pointer,ptr_lx,ptr_ly

  allocate(datapointer(lx,ly))
  datapointer(1:lx,1:ly)=reshape([5,4,3,2,1,10,9,8,7,6,15,12,13,12,11],[lx,ly])
  print*, ' print pointer array after assignment'
  call print_data_rows(datapointer,lx,ly)
  ptr_pointer=c_loc(datapointer)
  ptr_lx=c_loc(lx)
  ptr_ly=c_loc(ly)
end subroutine bindpointer
