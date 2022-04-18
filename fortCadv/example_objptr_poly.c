#include <stdio.h>
int main() {
  void* objptr1;                                        // pointers for various fortran data
  void* objptr2;
  int objtype;
  int lx,ly;
  double* arrptr;

  void extern objconstruct_C(int*, void**, double**, int*, int*);
  void extern objuse_C(int*, void*);

  printf(" Making object1\n");
  objtype=1;
  lx=2;
  ly=2;
  double arraydata[]={1,2,3,4};
  arrptr=&arraydata[0];
  objconstruct_C(&objtype,&objptr1,&arrptr,&lx,&ly);
  printf(" Using object1\n");
  objuse_C(&objtype,&objptr1);

  printf(" Making object2\n");
  objtype=2;
  lx=2;
  ly=3;
  double arraydata2[]={6,5,4,3,2,1};
  arrptr=&arraydata2[0];
  objconstruct_C(&objtype,&objptr2,&arrptr,&lx,&ly);
  printf(" Using object2\n");
  objuse_C(&objtype,&objptr2);

  // just call everything again to make sure objects persist
  printf(" Using object1 again\n");
  objtype=1;
  objuse_C(&objtype,&objptr1);

  printf(" Using object1 again\n");
  objtype=2;
  objuse_C(&objtype,&objptr2);

  return(0);
}

