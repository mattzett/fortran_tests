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
	$(LL) *.o -o example_formodvar

clean:
	rm *.o
	rm *.mod
	rm example_formodvar

