program example_pointers

implicit none (type, external)

integer :: N=5
integer, pointer :: ptr_N
integer, pointer :: ptr2_N

allocate(ptr_N)
ptr_N=10
ptr2_N=>ptr_N
print*, ptr_N
print*, ptr2_N
print*, N

end program example_pointers
