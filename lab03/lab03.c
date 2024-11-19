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

int treat_deci(char* inp_buf){
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

void treat_hex(char* inp_buf, char* num_hex){
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


void hex_to_bin(char* hex, char* bin){
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
        }else if (hex[i] >= 'a' && hex[i] <= 'f'){
            aux = hex[i] - 'a' + 10;
        }
        for (j = 3; j >= 0; j--){
            bin[i*4 + j] = (aux % 2) + '0';
            aux = aux / 2;
        }
        i++;
    }

    bin[i*4+j+1] = '\n';
    
}


void num_deci_to_num_decis(unsigned int num_deci, char* num_decis, int neg){

    if (neg){
        num_decis[0] = '-';
    }
    
    int i = 11;
    
    while (num_deci > 0){
        num_decis[i] = (num_deci % 10) + '0';
        num_deci = num_deci / 10;
        i--;
    }

}

void num_deci_to_num_bin(unsigned int num_deci, char* num_bins, int neg){

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

void num_deci_to_hex(unsigned int deci, char* hex){
    int i = 8;
    while(deci > 0){
        int aux = deci % 16;
        if (aux >= 10){
            hex[i] = 'a' + (aux % 10);
        }else{
            hex[i] = '0' + aux;
        }
        deci /= 16;
    }
}

void hex_to_inv_hex(char* hex, char* inv_hex_num){

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

void num_bins_to_hex(char* num_bins, char* num_hex){
    int i = 0;
    int j = 0;
    while (i < 32){
        int aux = 0;
        for (int k = 0; k < 4; k++){
            aux = aux * 2 + (num_bins[i] - '0');
            i++;
        }
        if (aux >= 10){
            num_hex[j] = 'a' + (aux % 10);
        }else{
            num_hex[j] = '0' + aux;
        }
        j++;
    }
}

void print_bin(char* binNum){
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

void print_decis(char* deciNum){
    int i = 0;
    char aux[12] = "00000000000\n";
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
    
    for (; j < 12 - i; j++){
        aux[j] = deciNum[i+j];
        if (aux[j] == '\n'){
            break;
        }
    }
    aux[11] = '\n';

    write(1, (void *) aux, j);
}

void bin_to_unsign_deci(char* bin, unsigned int* num_deci_aux){
    unsigned int num_deci = 0;
    for (int i = 0; i < 32; i++){
        num_deci = num_deci * 2 + (bin[i] - '0');
    }
    num_deci_aux[0] = num_deci;
}
void hex_to_unsign_deci(char* hex, unsigned int* num_deci_aux){
    unsigned int num_deci = 0;
    char bin[33];
    for (int i = 0; i < 33; i++){
        bin[i] = '0';
    }
    hex_to_bin(hex, bin);
    bin_to_unsign_deci(bin, num_deci_aux);

}


int bin_to_deci(char* bin, unsigned int* num_deci_aux){
    unsigned int num_deci = 0;
    int i = 0;
    int neg = 0;

    while (bin[i] != '\n'){
        i++;
    }

    if (bin[0] == '1' && i == 32){
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
    
    num_deci_aux[0] =  num_deci;
    return neg;
}

int hexs_to_dec(char* hex, unsigned int* num_deci){

    int neg = 0;

    char aux_bin[33];
    for (int i = 0; i < 32; i++){
        aux_bin[i] = '0';
    }
    aux_bin[32] = '\n';

    hex_to_bin(hex, aux_bin);

    neg = bin_to_deci(aux_bin, num_deci);
    return neg;
}




void print_hex(char* hexNum){
    int i = 0;

    write(1, (void *) "0x", 2);

    while(hexNum[i] == '0'){
        i++;
    }

    char aux[9] = "00000000\n";

    int j = 0;
    for (; j < 9 - i - 1; j++){
        aux[j] = hexNum[i+j];
        if (aux[j] == '\n'){
            break;
        }
    }

    write(1, (void *) aux, j);
}

void do_it_hex(char* inp_buf){
    

    char num_hex[9] = "00000000\n";
    treat_hex(inp_buf, num_hex);
    
    unsigned int deci_aux[1];
    int neg = hexs_to_dec(num_hex, deci_aux);
    unsigned int deci = deci_aux[0];
    char num_decis[12] = "00000000000\n";
    num_deci_to_num_decis(deci, num_decis, neg);

    char num_bins[33];
    for (int i = 0; i < 33; i++){
        num_bins[i] = '0';
    }
    num_bins[32] = '\n';

    num_deci_to_num_bin(deci, num_bins, neg);
    
    char num_inv_hex[9] = "00000000\n";
    hex_to_inv_hex(num_hex, num_inv_hex);
    

    char num_inv_deci[12] = "00000000000\n";
    unsigned int inv_dec_aux[1];
    hex_to_unsign_deci(num_inv_hex, inv_dec_aux);
    unsigned int inv_dec = inv_dec_aux[0];
    num_deci_to_num_decis(inv_dec, num_inv_deci, 0);

    print_bin(num_bins);
    print_decis(num_decis);
    write(1, (void *) "\n", 1);
    print_hex(num_hex);
    write(1, (void *) "\n", 1);
    print_decis(num_inv_deci);
    write(1, (void *) "\n", 1);
}

void do_it_deci(char* inp_buf){
    
    int aux = treat_deci(inp_buf);
    unsigned int deci;
    int neg = 0;
    if (aux < 0){
        neg = 1;
        aux = -aux;
    }
    deci = aux;

    char num_bins[33];
    for (int i = 0; i < 33; i++){
        num_bins[i] = '0';
    }

    num_bins[32] = '\n';
    num_deci_to_num_bin(deci, num_bins, neg);

    char num_hex[9] = "00000000\n";
    num_bins_to_hex(num_bins, num_hex);

    char num_inv_hex[9] = "00000000\n";
    hex_to_inv_hex(num_hex, num_inv_hex);

    char num_inv_deci[12] = "00000000000\n";

    unsigned int inv_dec_aux[1];
    hex_to_unsign_deci(num_inv_hex, inv_dec_aux);
    unsigned int inv_dec = inv_dec_aux[0];
    num_deci_to_num_decis(inv_dec, num_inv_deci, 0);

    print_bin(num_bins);
    print_decis(inp_buf);
    write(1, (void *) "\n", 1);
    print_hex(num_hex);
    write(1, (void *) "\n", 1);
    print_decis(num_inv_deci);
    write(1, (void *) "\n", 1);

}

int main() {
    
    char input_buf[11];
    
    read(0, (void *) input_buf, 11);
    
    int hex = 0;
    int neg = 0;

    if (input_buf[0] == '0'){
        hex = 1;
    }else if (input_buf[0] == '-'){
        neg = 1;
    }

    if (hex){
        do_it_hex(input_buf);
    }else{
        do_it_deci(input_buf);
    }

    return 0;
}


void _start() {
    int ret_code = main();
    exit(ret_code);
}
