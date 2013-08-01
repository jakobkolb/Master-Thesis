FC = gfortran

OPT =

PROGRAMS = BDS

BDS: global.o init.o push.o statistics.o

init.o: global.o

push.o: global.o

statistics.o: global.o

% : %.o
	$(FC) $(OPT) -o $@ $^

%.o : %.f90
	$(FC) $(OPT) -c $<

clean:
	rm -f *.o *.mod *.MOD
