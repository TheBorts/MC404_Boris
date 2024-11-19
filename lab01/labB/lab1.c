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

void _start() {
    int ret_code = main();
    exit(ret_code);
}

int main() {
    char input_buf[5];
    read(0, (void *) input_buf, 5);
    int a = 0;
    int b = 0;

    switch (input_buf[0]) {
        case '1':
            a = 1;
            break;
        case '2':
            a = 2;
            break;
        case '3':
            a = 3;
            break;
        case '4':
            a = 4;
            break;
        case '5':
            a = 5;
            break;
        case '6':
            a = 6;
            break;
        case '7':
            a = 7;
            break;
        case '8':
            a = 8;
            break;
        case '9':
            a = 9;
            break;
        default:
            break;
    }
    switch (input_buf[4]) {
        case '1':
            b = 1;
            break;
        case '2':
            b = 2;
            break;
        case '3':
            b = 3;
            break;
        case '4':
            b = 4;
            break;
        case '5':
            b = 5;
            break;
        case '6':
            b = 6;
            break;
        case '7':
            b = 7;
            break;
        case '8':
            b = 8;
            break;
        case '9':
            b = 9;
            break;
        default:
            break;
    }

    char str[2];
    int num = 0;
    switch (input_buf[2]){
        case '+':
            num = a + b;
            break;
        case '-':
            num = a - b;
            break;
        case '*':
            num = a * b;
            break;
        default:
            break;
    }

    str[0] = num + '0';
    str[1] = '\n';

    write(1, str, 2);
    return 0;
}
