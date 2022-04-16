FC=gfortran
CC=gcc
LL=gfortran

all:
	$(FC) -c datamod_poly.f90 -o datamod_poly.o
	$(FC) -c c_interface_poly.f90 -o c_interface_poly.o
	$(CC) -c example_objptr_poly.c
	$(LL) datamod_poly.o c_interface_poly.o example_objptr_poly.o -o example_objptr_poly

clean:
	rm *.o
	rm *.mod
	rm example_objptr_poly

