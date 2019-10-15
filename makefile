
mystery: mystery.c
	gcc -Wall mystery.c -o mystery
formula: formula.c
	gcc -Wall -o formula ncr.s nCr.h formula.c formula.h
clean:
	rm formula; rm mystery
