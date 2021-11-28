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

void main(){
  int a, b, c, n;

  a = 1;
  b = 2;
  n = 10;

  for(int i = 1; i <= n-2; i++){
    c = a + b;
    printInt(c);
    printChar(10);
    a = b;
    b = c;
  }
}
