# Makefile

OBJS	= bison.o lex.yy.o main.o

CC	= g++
CFLAGS	= -g -Wall -ansi -pedantic

expr:	$(OBJS)
		$(CC) $(CFLAGS) $(OBJS) -o expr -lfl

lex.yy.o: lex.yy.c
		$(CC) $(CFLAGS) -c lex.yy.c -o lex.yy.o

lex.yy.c: expr.lex 
		/usr/bin/flex expr.lex

bison.o: bison.c
		$(CC) $(CFLAGS) -c bison.c -o bison.o

bison.c: expr.y
		/usr/bin/bison -d -v expr.y
		cp expr.tab.c bison.c
		cmp -s expr.tab.h tok.h || cp expr.tab.h tok.h

main.o:	main.cc
		$(CC) $(CFLAGS) -c main.cc -o main.o

lex.yy.o yac.o main.o	: main.h
lex.yy.o main.o		: tok.h

clean:
	rm -f *.o *~ lex.c lex.yy.c bison.c tok.h expr.tab.c expr.tab.h expr.output expr

