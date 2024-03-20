
ASSN = 1
CLASS= cs143
CLASSDIR= ../..
COOLC = ${CLASSDIR}/bin/coolc
SPIM = ${CLASSDIR}/bin/spim

SRC= stack.cl README 
LSRC= Makefile atoi.cl stack.test

DEPENDS = ${CLASSDIR}/examples/atoi.cl

CC=gcc
CFLAGS=-g
 
.c.o:
	${CC} ${CFLAGS} -c $<

%.s: %.cl
	${COOLC} $< ${DEPENDS}

%: %.s
	${SPIM} -file $<

.PHONY: run
run: $(fname).s
	${SPIM} -file $<

# test:	compile
# 	@echo stack.test
# 	${CLASSDIR}/bin/spim -file stack.s < stack.test

.PHONY: clean
clean :
	rm -f *.s core *~
