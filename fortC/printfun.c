#include <stdio.h>
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
