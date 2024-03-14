
ASSN = 1
CLASS= cs143
CLASSDIR= ../..
SRC= stack.cl README 
LSRC= Makefile atoi.cl stack.test


CC=gcc
CFLAGS=-g

.c.o:
	${CC} ${CFLAGS} -c $<

%.s: %.cl
	${CLASSDIR}/bin/coolc $<

run_%: %.s
	${CLASSDIR}/bin/spim -file $<

.PHONY: run
run: $(fname).s
	${CLASSDIR}/bin/spim -file $<

# test:	compile
# 	@echo stack.test
# 	${CLASSDIR}/bin/spim -file stack.s < stack.test

.PHONY: clean
clean :
	rm -f *.s core *~
