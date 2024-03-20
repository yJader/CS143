
ASSN = 1
CLASS= cs143
CLASSDIR= ../..
SRC= stack.cl README 
LSRC= Makefile atoi.cl stack.test

CC=gcc
CFLAGS=-g

.c.o:
	${CC} ${CFLAGS} -c $<

compile: stack.s

stack.s: stack.cl atoi.cl
	${CLASSDIR}/bin/coolc stack.cl atoi.cl

run:compile
	${CLASSDIR}/bin/spim -file stack.s

test:	compile
	@echo stack.test
	${CLASSDIR}/bin/spim -file stack.s < stack.test

my_compile: my_stack.s

my_stack.s: my_stack.cl atoi.cl
	${CLASSDIR}/bin/coolc my_stack.cl atoi.cl

my_run: my_compile
	${CLASSDIR}/bin/spim -file my_stack.s

my_test:	my_compile
	@echo stack.test
	${CLASSDIR}/bin/spim -file my_stack.s < stack.test

clean :
	rm -f *.s core *~
