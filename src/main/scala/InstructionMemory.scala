import chisel3._
import chisel3.util.experimental.loadMemoryFromFile

class InstructionMemory extends Module{
  val io = IO(new Bundle{
    val address = Input(UInt(32.W))
    val instOut = Output(UInt(32.W))
  })
  val instMem = Mem(4096, UInt(32.W))
  io.instOut := instMem.read(io.address)

  // Program is loaded to instruction memory
  loadMemoryFromFile(instMem, "Machine code.txt")
}