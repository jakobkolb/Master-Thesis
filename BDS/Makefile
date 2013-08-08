FC = gfortran

OPT = -fopenmp

PROGRAMS = BDS

BDS: global.o init.o push.o statistics.o stat5.o

init.o: global.o stat5.o

push.o: global.o

statistics.o: global.o stat5.o

% : %.o
	$(FC) $(OPT) -o $@ $^

%.o : %.f90
	$(FC) $(OPT) -c $<

clean:
	rm -f *.o *.mod *.MOD
