import chisel3._

class ProgramCounter extends Module{
  val io = IO(new Bundle{
    val pCSel, haltPC = Input(Bool())
    val aLUIn = Input(UInt(32.W))
    val pCOut = Output(UInt(32.W))
    val pCPlus4 = Output(UInt(32.W))
  })

  val counter = RegInit(0.U(32.W))

  when(!io.haltPC){
    when(!io.pCSel){
      counter := counter + 4.U
    }. otherwise{
      counter := io.aLUIn
    }
  }
  io.pCOut := counter
  io.pCPlus4 := counter + 4.U
}
