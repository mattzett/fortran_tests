#include <stdio.h>
void main(){
void printarray(int**,int,int);
int array[3][5]={{1,2,3,4,5},{6,7,8,9,10},{11,12,13,14,15}};

printarray(&array[0][0],3,5);
return;
}

// function that prints matrix
void printarray(int** array, int lx, int ly) {
  int i; 
  int j;

  printf("  printing from C function...");
  for (i=0;i<lx;i++){
    for (j=0;j<ly;j++){
      printf("%d %d %d ",i,j,array[i][j]);
    }
    printf("\n");
  }
}
