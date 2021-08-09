#include stdio.h
void main{
  double* dataptr                        // pointer to some fortran data
  extern void bindstatic(double*)        // bind our pointer to its array in fortran
  extern void print_data_row(double*)    // fortran routine to print array data to screen

  bindstatic(dataptr)
  print_data_row(dataptr)
}
