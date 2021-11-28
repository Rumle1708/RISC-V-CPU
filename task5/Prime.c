asm("li sp, 0x100000"); // SP set to 1 MB
asm("jal main");        // call main
asm("li a7, 10");       // prepare ecall exit
asm("ecall");           // now your simulator should stop

void printInt(int a){
  asm("li a7, 1");
  asm("ecall");
}

void printChar(char a){
  asm("li a7, 11");
  asm("ecall");
}

void printIsPrime(int a){
  printInt(a);
  printChar(' ');
  printChar('i');
  printChar('s');
  printChar(' ');
  printChar('p');
  printChar('r');
  printChar('i');
  printChar('m');
  printChar('e');
}

int modulo(int num, int d){ // %-operator
  if(num==0)
    return 0;
  else if(d==0)
    return -1;
  while(num>=d)
    num = num-d;
  return num;
}

void isPrime(int n){ // Determines if number is a prime
  int flag = 0;
  for(int i = 2; i <= (n>>1); i++){
    if(modulo(n,i) == 0){
      flag = 1;
      break;
    }
  }
  if(!flag){
    printIsPrime(n);
    printChar(10); // new line
  }
}

void main(){
  int max = 100;
  for(int n = 0; n < 3; n++){ // First 3
    isPrime(n);
  }
  for(int n = 3; n <= max; n += 2){ // Rest skips all multiple of 2
    isPrime(n);
  }
}
