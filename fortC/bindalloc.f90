subroutine bindalloc(ptr_alloc,ptr_lx,ptr_ly) bind(c)
  use datamod
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr
  type(c_ptr), intent(inout) :: ptr_alloc,ptr_lx,ptr_ly

  allocate(dataalloc(lx,ly))
  dataalloc(1:lx,1:ly)=reshape([15,14,13,12,11,10,9,8,7,6,5,4,3,2,1],[lx,ly])
  print*, ' print allocatable array after assignment'
  call print_data_rows(dataalloc,lx,ly)
  ptr_alloc=c_loc(dataalloc)
  ptr_lx=c_loc(lx)
  ptr_ly=c_loc(ly)
end subroutine bindalloc
