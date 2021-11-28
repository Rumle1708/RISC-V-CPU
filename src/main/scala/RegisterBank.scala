import chisel3._
import chisel3.util._

class RegisterBank extends Module{
  val io = IO(new Bundle{
    val dataA, dataB, a7 = Output(UInt(32.W))
    val rd, rs1, rs2 = Input(UInt(5.W))
    val dataIn = Input(UInt(32.W))
    val regWrite, eCall = Input(Bool())
    val call = Input(UInt(4.W))
  })

  val x = Reg(Vec(32,UInt(32.W)))

  x(0) := 0.U(32.W) // x0 hardwired to 0
  // x(2) := WireDefault(1048576.U) // Default stack pointer
  // Change data according to instruction
  io.dataA := x(io.rs1)
  io.dataB := x(io.rs2)

  // For ecall control
  io.a7 := x(17.U)

  when(io.regWrite && io.rd =/= 0.U){
    // Only write to reg x1 - x31
    x(io.rd) := io.dataIn
  }

  // ECALL
  when(io.eCall) {
    switch(io.call) {
      is(0.U) { // print_int
        printf("%d", x(10).asSInt())
      }
      is(1.U) { //print_float
        printf(p"${x(10)}.00")
      }
      is(2.U) { // Add later

      }
      is(3.U) { // Print registers
        for(i <- 0 until 8){
          for(j <- 0 until 4){
            printf("x(" + (j*8 + i) + ")")
            if(j*8 + i == 8 || j*8 + i == 9){
              printf(" ")
            }
            printf(p" = 0x${Hexadecimal(x(j*8 + i))}\t")
          }
          printf("\n")
        }
        printf("\n\n")
      }
      is(4.U) { // print_char
        printf(p"${Character(x(10))}")
      }
      is(5.U) { // print_hex
        printf(p"${Hexadecimal(x(10))}")
      }
      is(6.U) { // print_binary
        printf(p"${Binary(x(10))}")
      }
      is(7.U) { // print_unsigned
        printf("%d", x(10).asUInt())
      }
      is(8.U) { // status_exit
        printf("Status code: %d", x(10).asSInt())
      }
    }
  }
}