import chisel3._
import chisel3.util._

import ALU._

object ALU {
  // ALU constants
  val ADD = 0.U(4.W)
  val SUB = 1.U(4.W)
  val AND = 2.U(4.W)
  val OR = 3.U(4.W)
  val XOR = 4.U(4.W)
  val SLT = 5.U(4.W)
  val SLL = 6.U(4.W)
  val SLTU = 7.U(4.W)
  val SRL = 8.U(4.W)
  val SRA = 9.U(4.W)
}

class ALU extends Module{
  val io = IO(new Bundle{
    val aLUSel = Input(UInt(4.W))
    val aSel, bSel = Input(Bool())
    val dataA, dataB, pCIn, immIn = Input(UInt(32.W))
    val result = Output(UInt(32.W))
  })

  io.result := WireDefault(0.U)

  // Set correct operands
  val operandA = Mux(io.aSel, io.pCIn, io.dataA)
  val operandB = Mux(io.bSel, io.immIn, io.dataB)
  val shamt = operandB(4,0)

  switch(io.aLUSel){
    is(ADD){
      io.result := (operandA.asSInt() + operandB.asSInt()).asUInt()
    }
    is(SUB){
      io.result := (operandA.asSInt() - operandB.asSInt()).asUInt()
    }
    is(AND){
      io.result := operandA & operandB
    }
    is(OR){
      io.result := operandA | operandB
    }
    is(XOR){
      io.result := operandA ^ operandB
    }
    is(SLT){
      when(operandA.asSInt() < operandB.asSInt()){
        io.result := 1.U
      }. otherwise{
        io.result := 0.U
      }
    }
    is(SLL){
      io.result := operandA << shamt
    }
    is(SLTU){
      when(operandA < operandB){
        io.result := 1.U
      }. otherwise{
        io.result := 0.U
      }
    }
    is(SRL){
      io.result := operandA >> shamt
    }
    is(SRA){
      io.result := (operandA.asSInt() >> operandB).asUInt()
    }
  }
}