FC = gfortran

PROGRAMS = CSBD

all = $(PROGRAMS)

CSBD: global.o init.o step.o verlet.o

step.o: global.o

verlet.o: global.o

init.o: global.o verlet.o


%: %.o
	  $(FC) -o $@ $^

%.o: %.f90
	  $(FC) -c $<

clean:
	  rm -f *.o *.mod *.MOD

veryclean: clean
	  rm -f *~ $(PROGRAMS)

