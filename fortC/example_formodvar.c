#include <stdio.h>
void main() {
  double* dataptr;                         // pointers for various fortran data
  double** dataptr2D;
  //double dataptr[3][5];
  double* dataptralloc;
  double* dataptrpointer;
  int* lxptr;
  int* lyptr;
  int i; int j;

  void printarray(double**,int,int);
  extern void bindstatic(double**, int**, int**);        // bind our pointer to its array in fortran
  extern void bindalloc(double**);
  extern void bindpointer(double**);
  extern void print_data_rows(double**);    // fortran routine to print array data to screen

  // have fortran bind static array to C pointer
  printf("static array\n");
  bindstatic(&dataptr,&lxptr,&lyptr);
  printf("  C sees size lx,ly = %d %d\n",*lxptr,*lyptr);

  // print static array as seen by C
  printf("  printed from C (linear):  \n");
  for (i=0;i<(*lxptr)*(*lyptr);i++){
      printf("%5.2f ",dataptr[i]);
  }
  printf("\n");
  //printarray(dataptr,*lxptr,*lyptr);

  // make a small change to array and print again
  dataptr[2*3]=9999.0;
  printf("  print from C (linear) after change:  \n");
  for (i=0;i<(*lxptr)*(*lyptr);i++){
      printf("%5.2f ",dataptr[i]);
  }
  printf("\n");

  // visualize as a 2D array
  bindstatic(&dataptr2D,&lxptr,&lyptr);
  printarray(dataptr2D,*lxptr,*lyptr);

  // make print static array as seen by fortran
  // FIXME: must convert to fortran array pointer of set size...
  //print_data_rows(&dataptr);

  printf("allocatable array\n");
  bindalloc(&dataptralloc);
  //print_data_rows(dataptralloc);

  printf("pointer/allocatable array\n");
  bindpointer(&dataptrpointer);
  //print_data_rows(dataptrpointer);
  return;
}


// function that prints matrix
void printarray(double** array, int lx, int ly) {
  int i; 
  int j;

  printf("  printing from C function...");
  for (i=0;i<lx;i++){
    for (j=0;j<ly;j++){
      printf("%d %d %5.2f ",i,j,array[i][j]);
    }
    printf("\n");
  }
}
