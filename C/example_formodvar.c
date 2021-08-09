#include <stdio.h>
void main() {
  double* dataptr;                         // pointers for various fortran data
  double* dataptralloc;
  double* dataptrpointer;
  int* lx;
  int* ly;
  extern void bindstatic(double**, int**, int**);        // bind our pointer to its array in fortran
  extern void bindalloc(double**);
  extern void bindpointer(double**);
  extern void print_data_rows(double**);    // fortran routine to print array data to screen

  printf("static array\n");
  bindstatic(&dataptr,&lx,&ly);
  printf("lx,ly = %d %d\n",*lx,*ly);
  //printf("  printed from C:  ")
  //print_data_rows(&dataptr);

  printf("allocatable array\n");
  bindalloc(&dataptralloc);
  //print_data_rows(dataptralloc);

  printf("pointer/allocatable array\n");
  bindpointer(&dataptrpointer);
  //print_data_rows(dataptrpointer);
  return;
}
