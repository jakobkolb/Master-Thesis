FC = ifort

CC = gcc

OPT = -openmp -O3
PROF =# -g -pg

PROGRAMS = BDS

BDS: global.o init.o push.o statistics.o stat5.o timedif.o

init.o: global.o stat5.o statistics.o

push.o: global.o

statistics.o: global.o stat5.o

% : %.o
	$(FC) $(OPT) $(PROF) -o $@ $^

%.o : %.f90
	$(FC) $(OPT) $(PROF) -c $<

%.o : %.c
	$(CC) $(OPT) -c $<

clean:
	rm -f *.o *.mod *.MOD
