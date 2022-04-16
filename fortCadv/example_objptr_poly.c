#include <stdio.h>
int main() {
  void* objptr1;                                        // pointers for various fortran data
  void* objptr2;
  int objtype;
  void extern objconstruct_C(int*, void**);
  void extern objuse_C(int*, void**);

  printf(" Making object1\n");
  objtype=1;
  objconstruct_C(&objtype,&objptr1);
  printf(" Using object1\n");
  objuse_C(&objtype,&objptr1);

  printf(" Making object2\n");
  objtype=2;
  objconstruct_C(&objtype,&objptr2);
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

