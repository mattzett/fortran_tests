#include <stdio.h>
void main() {
  double* dataptr;                                        // pointers for various fortran data
  double* dataptralloc;
  double* dataptrpointer;
  int* lxptr;
  int* lyptr;
  int i; int j;

  void printmat(double*,int,int);
  void printvec(double*,int);
  extern void bindstatic(double**, int**, int**);        // bind our pointer to its array in fortran, arguments are c_ptrs passed by reference, so pointers to pointers...
  extern void bindalloc(double**, int**, int**);
  extern void bindpointer(double**, int**, int**);
  extern void print_data_rows(double*, int*, int*);       // fortran routine to print array data to screen

  /////////////////////////////////////////////////////////////////////////////////////////
  // First test bindings for a static array
  ////////////////////////////////////////////////////////////////////////////////////////
  // have fortran bind static array to C pointer
  lxptr=NULL; lyptr=NULL; dataptr=NULL;
  printf("===============================================================================\n");
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

  // print static array as using fortran
  print_data_rows(dataptr,lxptr,lyptr);


  //////////////////////////////////////////////////////////////////////////////////////////
  // Now check binding for a fortran allocatabl array
  //////////////////////////////////////////////////////////////////////////////////////////
  lxptr=NULL; lyptr=NULL; dataptralloc=NULL;
  printf("===============================================================================\n");
  printf("allocatable array\n");
  bindalloc(&dataptralloc,&lxptr,&lyptr);
  printf("  C sees size lx,ly = %d %d\n",(*lxptr),(*lyptr));

  // print allocatable array as seen by C
  printvec(dataptralloc,(*lxptr)*(*lyptr));

  // make a small change and check
  dataptralloc[1]=-1.0;
  printvec(dataptralloc,(*lxptr)*(*lyptr));

  // print modified C memory space as a matrix
  printmat(dataptralloc,*lxptr,*lyptr);

  // print allocatable and modified array using fortran
  print_data_rows(dataptralloc,lxptr,lyptr);


  //////////////////////////////////////////////////////////////////////////////////////////
  // Now check binding for a fortran pointer (to an array)
  //////////////////////////////////////////////////////////////////////////////////////////
  lxptr=NULL; lyptr=NULL; dataptrpointer=NULL;
  printf("===============================================================================\n");
  printf("pointer/allocatable array\n");
  bindpointer(&dataptrpointer,&lxptr,&lyptr);
  printf("  C sees size lx,ly = %d %d\n",(*lxptr),(*lyptr));

  // print pointer/array as seen by C
  printvec(dataptrpointer,(*lxptr)*(*lyptr));

  // make a small change and reprint
  dataptrpointer[5]=0.0;
  printvec(dataptrpointer,(*lxptr)*(*lyptr));
  
  // print as a matrix
  printmat(dataptrpointer,*lxptr,*lyptr);

  // use fortran routine to print same memory space
  print_data_rows(dataptrpointer,lxptr,lyptr);

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
