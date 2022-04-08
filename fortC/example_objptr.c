#include <stdio.h>
int main() {
  void* objptr;                                        // pointers for various fortran data
  int lx,ly;
  void extern objref(void**, int*, int*);
  void extern objprint(void**);

  // try to bind a pointer to the object data and see if we can print/access the data
  objref(&objptr,&lx,&ly);
  objprint(&objptr);

  return(0);
}

