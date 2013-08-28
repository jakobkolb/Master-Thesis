FC = gfortran

CC = gcc

OPT = -fopenmp -O3

PROGRAMS = BDS

BDS: global.o init.o push.o statistics.o stat5.o timedif.o

init.o: global.o stat5.o

push.o: global.o

statistics.o: global.o stat5.o

% : %.o
	$(FC) $(OPT) -o $@ $^

%.o : %.f90
	$(FC) $(OPT) -c $<

%.o : %.c
	$(CC) $(OPT) -c $<

clean:
	rm -f *.o *.mod *.MOD
