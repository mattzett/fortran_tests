#include <stdio.h>
int main() {
  void* objptr1;                                        // pointers for various fortran data
  void* objptr2;
  int objtype;
  void extern objconstruct(int*, void**);
  void extern objuse(int*, void**);

  printf(" Making object1\n");
  objtype=1;
  objconstruct(&objtype,&objptr1);
  printf(" Using object1\n");
  objuse(&objtype,&objptr1);

  printf(" Making object2\n");
  objtype=2;
  objconstruct(&objtype,&objptr2);
  printf(" Using object2\n");
  objuse(&objtype,&objptr2);

  printf(" Using object1 again\n");
  objtype=1;
  objuse(&objtype,&objptr1);

  printf(" Using object1 again\n");
  objtype=2;
  objuse(&objtype,&objptr2);

  return(0);
}

