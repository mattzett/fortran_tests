! take a C handle to a fortran object and print it
subroutine objprint(handle) bind(C)
  use datamod, only: dataobj
  use, intrinsic :: iso_c_binding, only: c_ptr,c_f_pointer

  type(dataobj), pointer :: obj
  type(c_ptr), intent(inout) :: handle

  call c_f_pointer(handle,obj)
  call obj%print_data()
end subroutine objprint
