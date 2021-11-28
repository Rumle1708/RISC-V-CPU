import chisel3._
import chisel3.util._

import ImmediateGenerator._

object ImmediateGenerator{
  val type0Imm  = "b000".U
  val typeIImm  = "b001".U
  val typeSImm  = "b010".U
  val typeUImm  = "b011".U
  val typeUJImm = "b100".U
  val typeBImm  = "b101".U
}

class ImmediateGenerator extends Module{
  val io = IO(new Bundle{
    val immIn = Input(UInt(25.W))
    val immSel = Input(UInt(3.W))
    val immOut = Output(UInt(32.W))
  })

  io.immOut := WireDefault(0.U)

  // Sign extension and immediate selection
  switch(io.immSel){
    is(type0Imm){
      io.immOut := 0.U
    }
    is(typeIImm){
      io.immOut := Cat(Fill(20,io.immIn(24)),io.immIn(24,13))
    }
    is(typeSImm){
      io.immOut := Cat(Fill(20,io.immIn(24)),io.immIn(24,18), io.immIn(4,0))
    }
    is(typeUImm){
      io.immOut := Cat(io.immIn(24,5), Fill(12,0.U))
    }
    is(typeUJImm){
      io.immOut := Cat(Fill(12,io.immIn(24)),io.immIn(24), io.immIn(12,5), io.immIn(13), io.immIn(23,14), "b0".U)
    }
    is(typeBImm){
      io.immOut := Cat(Fill(19,io.immIn(24)),io.immIn(24,18), io.immIn(4,1), "b0".U)
    }
  }
}