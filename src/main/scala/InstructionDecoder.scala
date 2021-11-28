import chisel3._
import chisel3.util._

class InstructionDecoder extends Module{
  val io = IO(new Bundle{
    val inst = Input(UInt(32.W))
    val rd, rs1, rs2 = Output(UInt(5.W))
    val imm = Output(UInt(25.W))
    val ctrl = Output(UInt(9.W))
  })
  // Split instruction into smaller parts
  io.rd := io.inst(11,7)
  io.rs1 := io.inst(19,15)
  io.rs2 := io.inst(24,20)
  io.imm := io.inst(31,7)
  io.ctrl := Cat(io.inst(30), io.inst(14,12), io.inst(6,2)) // 9 bits to control logic
}
