all: run.x

run.x: lab03.o
	ld lab03.o -o run.x
	
lab03.o: lab03.c
	clang-15 --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab03.c -o file1.o

lab03.s: lab03.c
	clang-15 --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab03.c -S -o lab03.s

clean:
	rm -f lab03.o run.x