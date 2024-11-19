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

int treat_deci(char inp_buf[11]){
    int i = 0;
    int num_deci = 0;
    int neg = 0;
    if (inp_buf[0] == '-'){
        neg = 1;
        i++;
    }
    while(inp_buf[i] != '\n'){
        num_deci = num_deci * 10 + (inp_buf[i] - '0');
        i++;
    }
    if (neg){
        num_deci = -num_deci;
    }
    return num_deci;
}

void treat_hex(char inp_buf[11], char num_hex[9]){
    int i = 2;
    int size = 0;

    while(inp_buf[i] != '\n'){
        size++;
        i++;
    }

    for (int j = 0; j < size; j++){
        num_hex[7-j] = inp_buf[size+1-j]; 
    }
}


void hex_to_bin(char hex[9], char bin[33]){
    int i = 0;
    int size = 0;
    for (int j = 0; j < 32; j++){
        bin[j] = '0';
    }

    int j = 0;
    while (hex[i] != '\n'){
        int aux = 0;
        if (hex[i] >= '0' && hex[i] <= '9'){
            aux = hex[i] - '0';
        }else if (hex[i] >= 'A' && hex[i] <= 'F'){
            aux = hex[i] - 'A' + 10;
        }
        for (j = 3; j >= 0; j--){
            bin[i*4 + j] = (aux % 2) + '0';
            aux = aux / 2;
        }
        i++;
    }

    bin[i*4+j+1] = '\n';
    
}


void num_deci_to_num_decis(int num_deci, char num_decis[11]){

    if (num_deci < 0){
        num_deci = -num_deci;
        num_decis[0] = '-';
    }
    int i = 10;
    while (num_deci > 0){
        num_decis[i] = (num_deci % 10) + '0';
        num_deci = num_deci / 10;
        i--;
    }

}

void num_deci_to_num_bin(int num_deci, char num_bins[33]){
    int neg = 0;
    
    if (num_deci < 0){
        num_deci = -num_deci;
        neg = 1;
    }
    
    for (int i = 31; i >= 0; i--){
            if (num_deci % 2 == 0){
                num_bins[i] = '0';
            }else{
                num_bins[i] = '1';
            }
            num_deci = num_deci / 2;
        }

    if (neg){
        for (int i = 0; i < 32; i++){
            if (num_bins[i] == '1'){
                num_bins[i]--;
            }else{
                num_bins[i]++;
            }
        }
        int carry = 1;
        for (int i = 31; i >= 0; i--){
            if (num_bins[i] == '1' && carry == 1){
                num_bins[i] = '0';
            }else if (num_bins[i] == '0' && carry == 1){
                num_bins[i] = '1';
                carry = 0;
                break;
            }
        }
    }
}

void num_deci_to_hex(int deci, char hex[9]){
    int i = 8;
    while(deci > 0){
        int aux = deci % 16;
        if (aux >= 10){
            hex[i] = 'A' + (aux % 10);
        }else{
            hex[i] = '0' + aux;
        }
        deci /= 16;
    }
}

void hex_to_inv_hex(char hex[9], char inv_hex_num[9]){

    int i = 8;

    inv_hex_num[8] = '\n';

    inv_hex_num[0] = hex[6];
    inv_hex_num[1] = hex[7];
    inv_hex_num[2] = hex[4];
    inv_hex_num[3] = hex[5];
    inv_hex_num[4] = hex[2];
    inv_hex_num[5] = hex[3];
    inv_hex_num[6] = hex[0];
    inv_hex_num[7] = hex[1];
    
}

void num_bins_to_hex(char num_bins[33], char num_hex[9]){
    int i = 0;
    int j = 0;
    while (i < 32){
        int aux = 0;
        for (int k = 0; k < 4; k++){
            aux = aux * 2 + (num_bins[i] - '0');
            i++;
        }
        if (aux >= 10){
            num_hex[j] = 'A' + (aux % 10);
        }else{
            num_hex[j] = '0' + aux;
        }
        j++;
    }
}

void print_bin(char binNum[33]){
    char out[3] = "0b";
    write(1, (void *) out, 2);
    
    int i = 0; 
    while (binNum[i] == '0'){
        i++;
    }

    char aux[33];
    for (int i = 0; i < 33; i++){
        aux[i] = '0';
    }


    for (int j = 0; j < 33 - i; j++){
        aux[j] = binNum[i+j];
    }

    write(1, (void *) aux, 33-i);
}
int bin_to_deci(char bin[33]){
    int num_deci = 0;
    int i = 0;
    int neg = 0;

    while (bin[i] != '\n'){
        i++;
    }

    if (bin[0] == '1' && i == 32){
        write(1, (void *) "entrou\n", 7);
        neg = 1;
        for (int j = 0; j < 32; j++){
            if (bin[j] == '1'){
                bin[j] = '0';
            }else{
                bin[j] = '1';
            }
        }
        int carry = 1;
        for (int j = 31; j >= 0; j--){
            if (bin[j] == '1' && carry == 1){
                bin[j] = '0';
            }else if (bin[j] == '0' && carry == 1){
                bin[j] = '1';
                carry = 0;
                break;
            }
        }
    }
    for (int j = 0; j < 32; j++){
        num_deci = num_deci * 2 + (bin[j] - '0');
    }
    if (neg){
        num_deci = -num_deci;
    }
    return num_deci;
}

int hexs_to_dec(char hex[9]){
    char aux_bin[33];
    for (int i = 0; i < 32; i++){
        aux_bin[i] = '0';
    }
    aux_bin[32] = '\n';
    hex_to_bin(hex, aux_bin);

    int num_deci = bin_to_deci(aux_bin);
        
    return num_deci;
}

void print_decis(char deciNum[11]){
    int i = 0;
    char aux[11] = "0000000000";
    int j = 0;
    
    if (deciNum[0] == '-'){
        aux[0] = '-';
        i++;
        j++;
    }

    while (deciNum[i] == '0'){
        i++;
    }

    if(j){
        i--;    
    }
    
    for (; j < 11 - i; j++){
        aux[j] = deciNum[i+j];
        if (aux[j] == '\n'){
            break;
        }
    }

    write(1, (void *) aux, j);
}


void print_hex(char hexNum[9]){
    int i = 0;

    write(1, (void *) "0x", 2);

    while(hexNum[i] == '0'){
        i++;
    }

    char aux[9] = "00000000";

    int j = 0;
    for (; j < 9 - i - 1; j++){
        aux[j] = hexNum[i+j];
        if (aux[j] == '\n'){
            break;
        }
    }

    write(1, (void *) aux, j);
}

int main(){
    
    int num = -9615;

    char num_bin[33];
    for (int i = 0; i < 33; i++){
        num_bin[i] = '0';
    }

    char num_hex[9] = "00000000";
    char num_decis[11] = "0000000000";
    char num_inv_hex[9] = "00000000";
    char num_inv_decis[11] = "0000000000";

    num_deci_to_num_bin(num, num_bin);
    print_bin(num_bin);
    write(1, (void *) "\n", 1);
    
    num_bins_to_hex(num_bin, num_hex);
    print_hex(num_hex);
    write(1, (void *) "\n", 1);

    num_deci_to_num_decis(num, num_decis);
    print_decis(num_decis);
    write(1, (void *) "\n", 1);
    
    hex_to_inv_hex(num_hex, num_inv_hex);
    print_hex(num_inv_hex);
    write(1, (void *) "\n", 1);

    
    for (int i = 0; i < 33; i++){
        num_bin[i] = '0';
    }
    hex_to_bin(num_inv_hex, num_bin);
    print_bin(num_bin);
    write(1, (void *) "\n", 1);

    int inv = bin_to_deci(num_bin);
    num_deci_to_num_decis(inv, num_inv_decis);
    print_decis(num_inv_decis);
    write(1, (void *) "\n", 1);

    
    return 0;

}


void _start() {
    int ret_code = main();
    exit(ret_code);
}