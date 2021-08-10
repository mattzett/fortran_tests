#include <stdio.h>
void main() {
  double* dataptr;                         // pointers for various fortran data
  double* dataptralloc;
  double* dataptrpointer;
  int* lxptr;
  int* lyptr;
  int i; int j;

  void printmat(double*,int,int);
  void printvec(double*,int);
  extern void bindstatic(double**, int**, int**);        // bind our pointer to its array in fortran, arguments are c_ptrs passed by reference, so pointers to pointers...
  extern void bindalloc(double**);
  extern void bindpointer(double**);
  extern void print_data_rows(double*, int*, int*);                  // fortran routine to print array data to screen

  // have fortran bind static array to C pointer
  printf("static array\n");
  bindstatic(&dataptr,&lxptr,&lyptr);
  printf("  C sees size lx,ly = %d %d\n",(*lxptr),(*lyptr));

  // print static array as seen by C
  printvec(dataptr,(*lxptr)*(*lyptr));

  // make a small change to array and print again
  dataptr[6]=9999.0;
  printvec(dataptr,(*lxptr)*(*lyptr));

  // visualize as a 2D array
  printmat(dataptr,(*lxptr),(*lyptr));

  // make print static array as seen by fortran
  print_data_rows(dataptr,lxptr,lyptr);

  printf("allocatable array\n");
  bindalloc(&dataptralloc);
  //print_data_rows(dataptralloc);

  printf("pointer/allocatable array\n");
  bindpointer(&dataptrpointer);
  //print_data_rows(dataptrpointer);
  return;
}

// function that prints matrix
void printmat(double* array, int lx, int ly) {
  int i; 
  int j;

  printf("  printing from C (matrix form):  \n");
  for (i=0;i<lx;i++){
    for (j=0;j<ly;j++){
      printf("%5.2f ",*(array+i*ly+j));
    }
    printf("\n");
  }
}

// function that prints as a linear array (vector)
void printvec(double* array, int lx) {
  int i;
  int j;

  printf("  printed from C (vector form):  \n");
  for (i=0;i<lx;i++){
      printf("%5.2f ",array[i]);
  }
  printf("\n");
}
