import chisel3._

class BranchComparator extends Module{
  val io = IO(new Bundle{
    val dataA, dataB = Input(UInt(32.W))
    val brUn = Input(Bool())
    val brEq, brLT = Output(Bool())
  })

  io.brEq := io.dataA === io.dataB

  when(io.brUn){
    io.brLT := io.dataA < io.dataB
  }. otherwise{
    io.brLT := io.dataA.asSInt() < io.dataB.asSInt()
  }
}