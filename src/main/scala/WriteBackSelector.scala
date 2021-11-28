import chisel3._
import chisel3.util._

import WriteBackSelector._

object WriteBackSelector{
  // WBSel
  val mem = "b00".U
  val aLU = "b01".U
  val pCPlus4 = "b10".U
}

class WriteBackSelector extends Module{
  val io = IO(new Bundle{
    val memIn, aLUIn, pCplus4 = Input(UInt(32.W))
    val wBSel = Input(UInt(2.W))
    val wBOut = Output(UInt(32.W))
  })

  io.wBOut := WireDefault(0.U)

  switch(io.wBSel) {

    is(mem) {
      io.wBOut := io.memIn
    }

    is(aLU) {
      io.wBOut := io.aLUIn
    }

    is(pCPlus4) {
      io.wBOut := io.pCplus4
    }

  }
}
