FC=gfortran
CC=gcc
LL=gfortran

all:
	$(FC) -c datamod.f90 -o datamod.o
	$(FC) -c bindstatic.f90 -o bindstatic.o
	$(FC) -c bindalloc.f90 -o bindalloc.o
	$(FC) -c bindpointer.f90 -o bindpointer.o
	$(CC) -c printfun.c
	$(CC) -c example_formodvar.c
	$(FC) -c bindobj.f90 -o bindobj.o
	$(CC) -c example_formodobj.c
	$(LL) datamod.o bindstatic.o bindalloc.o bindpointer.o printfun.o example_formodvar.o -o example_formodvar
	$(LL) datamod.o bindobj.o printfun.o example_formodobj.o -o example_formodobj

clean:
	rm *.o
	rm *.mod
	rm example_formodvar example_formodobj

