all: run.x

run.x: lab05a.o
	ld lab05a.o -o run.x
	
lab05a.o: lab05a.c
	clang-15 --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab05a.c -o lab05a.o

lab05a.s: lab05a.c
	clang-15 --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab05a.c -S -o lab05a.s

clean:
	rm -f lab05a.o run.x