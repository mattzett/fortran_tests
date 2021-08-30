#include <stdio.h>
int main() {
  double* dataptr;                                        // pointers for various fortran data
  int lx;
  int ly;

  void printmat(double*,int,int);
  void printvec(double*,int);
  void extern bindobj(double**, int*, int*);

  // try to bind a pointer to the object data and see if we can print/access the data
  bindobj(&dataptr,&lx,&ly);
  printmat(dataptr,lx,ly);

  return(0);
}

