void exit(int code) {
    __asm__ __volatile__(
        "mv a0, %0           # return code\n"
        "li a7, 93           # syscall exit (64) \n"
        "ecall"
        :             // Output list
        :"r"(code)    // Input list
        : "a0", "a7"
    );
}

int read(int __fd, const void *__buf, int __n)
{
        int ret_val;
    __asm__ __volatile__(
        "mv a0, %1           # file descriptor\n"
        "mv a1, %2           # buffer \n"
        "mv a2, %3           # size \n"
        "li a7, 63           # syscall read code (63) \n"
        "ecall               # invoke syscall \n"
        "mv %0, a0           # move return value to ret_val\n"
        : "=r"(ret_val)                   // Output list
        : "r"(__fd), "r"(__buf), "r"(__n) // Input list
        : "a0", "a1", "a2", "a7"
    );
    return ret_val;
}


void write(int __fd, const void *__buf, int __n){
    __asm__ __volatile__(
        "mv a0, %0           # file descriptor\n"
        "mv a1, %1           # buffer \n"
        "mv a2, %2           # size \n"
        "li a7, 64           # syscall write (64) \n"
        "ecall"
        :   // Output list
        :"r"(__fd), "r"(__buf), "r"(__n)    // Input list
        : "a0", "a1", "a2", "a7"
    );
}

void hex_code(int val){
    char hex[11];
    unsigned int uval = (unsigned int) val, aux;

    hex[0] = '0';
    hex[1] = 'x';
    hex[10] = '\n';

    for (int i = 9; i > 1; i--){
        aux = uval % 16;
        if (aux >= 10)
            hex[i] = aux - 10 + 'A';
        else
            hex[i] = aux + '0';
        uval = uval / 16;
    }
    write(1, hex, 11);
}

void transforma(char* num, int* num_deci, int i){
    int j = 0;
    int num_deci_aux = 0;
    int neg = 0;
    if (num[0] == '-'){
        neg = 1;
    }
    j++;
    while(j < 5){
        num_deci_aux = num_deci_aux * 10 + (num[j] - '0');
        j++;
    }
    if (neg){
        num_deci_aux = -num_deci_aux;
    }
    
    num_deci[i] = num_deci_aux;
    
}

void pack(int num_deci, int quant, int *atual){
    for(int j = quant - 1; j >=0 ; j--){
        *atual = *atual << 1;
        *atual = *atual | ((num_deci >> j) & 1);
    }   
}

int main(){

    char num[7] = "000000";
    int num_deci[5];

    for(int i = 0; i < 5; i++){
        read(0, num, 6);
        transforma(num, num_deci, i);
    } 

    int atual[1] = {0};

    pack(num_deci[4], 11, atual);
    pack(num_deci[3], 5, atual);
    pack(num_deci[2], 5, atual);
    pack(num_deci[1], 8, atual);
    pack(num_deci[0], 3, atual);
    

    hex_code(*atual);
    
    return 0;
}

void _start() {
    int ret_code = main();
    exit(ret_code);
}

