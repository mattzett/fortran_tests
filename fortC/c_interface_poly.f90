module c_interface_poly
  use datamod_poly, only: dataobj_poly,data1,data2
  use, intrinsic :: iso_c_binding, only: c_loc,c_ptr,c_f_pointer
  implicit none
contains
  !> return a c pointer to a fortran polymorphic object that is created by this routine
  subroutine objconstruct(objtype,cptr_f90obj) bind(C)
    integer, intent(in) :: objtype
    type(c_ptr), intent(inout) :: cptr_f90obj
    class(dataobj_poly), pointer :: obj
    real(8), dimension(3,5) :: numbers
  
    ! allocate derived type
    select case (objtype)
      case (1)
        allocate(data1::obj)
      case (2)
        allocate(data2::obj)
      case default
        error stop 'unable to identify object type during construction'
    end select

    ! initialize some test data
    print*, 'Initializing test data...'
    numbers(1:3,1:5)=reshape([15,14,13,12,11,10,9,8,7,6,5,4,3,2,1],[3,5])
    call obj%set_data(numbers)
    call obj%print_data()
  
    ! bind pointers to C
    print*, 'Getting a C pointer to data object'
    cptr_f90obj=c_loc(obj)
  end subroutine objconstruct


  !> Use some of the polymorphic object methods and data
  subroutine objuse(objtype,objC) bind(C)
    type(c_ptr), intent(in) :: objC
    integer, intent(in) :: objtype
    class(dataobj_poly),pointer :: obj

    obj=>set_pointer_dyntype(objtype,objC)
    call obj%print_data()

!    if (objtype==1) then
!      print*, 'Extra status:  ',obj%datstat
!    else if (objtype==2) then
!      print*, 'Extra mag:  ',obj%datmag
!    end if
  end subroutine objuse


  !> set object pointer dynamic type to what is indicated in objtype
  function set_pointer_dyntype(objtype,objC) result(obj)
    type(c_ptr), intent(in) :: objC
    integer, intent(in) :: objtype
    class(dataobj_poly), pointer :: obj
    type(data1), pointer :: obj1
    type(data2), pointer :: obj2

    select case (objtype)
      case (1)
        call c_f_pointer(objC,obj1)
        obj=>obj1
      case (2)
        call c_f_pointer(objC,obj2)
        obj=>obj2
      case default
        error stop 'unable to identify object type during construction'
    end select

  end function set_pointer_dyntype
end module c_interface_poly
