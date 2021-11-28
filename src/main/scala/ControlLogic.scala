import chisel3._
import chisel3.util._

import ControlLogic._

object ControlLogic{

  // PC constants
  val PCAdd4 = false.B
  val PCAddALU = true.B

  // ALU constant
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

  // ALU input selection constants
  val Ars1 = false.B
  val APC = true.B
  val Brs2 = false.B
  val BImm = true.B

  // Memory constants
  val Read = false.B
  val Write = true.B
  val byte = "b00".U
  val hWord = "b01".U
  val word = "b10".U

  // WBSel
  val mem = "b00".U
  val aLU = "b01".U
  val pCPlus4 = "b10".U

  // Immediate select not functional?
  val type0Imm  = "b000".U
  val typeIImm  = "b001".U
  val typeSImm  = "b010".U
  val typeUImm  = "b011".U
  val typeUJImm = "b100".U
  val typeBImm  = "b101".U

  // Instruction type definitions
  val typeR   = "b01100".U // Arithmetic
  val typeI1  = "b00000".U // Load
  val typeI2  = "b00011".U // Fence
  val typeI3  = "b00100".U // Imm arithmetic
  val typeI4  = "b00110".U // Not used
  val typeI5  = "b11001".U // jalr
  val typeI6  = "b11100".U // System
  val typeS   = "b01000".U // Store
  val typeSB  = "b11000".U // Branch
  val typeU1  = "b01101".U // lui
  val typeU2  = "b00101".U // auipc
  val typeUJ  = "b11011".U // jal

  // Ecalls
  val print_int = 1.U
  val print_float = 2.U
  val print_string = 4.U
  val exit = 10.U
  val print_char = 11.U
  val print_hex = 34.U
  val print_bin = 35.U
  val print_unsigned = 36.U
  val status_code = 93.U
}

class ControlLogic extends Module{
  val io = IO(new Bundle{
    val ctrl = Input(UInt(9.W))
    val a7 = Input(UInt(32.W))
    val brEq, brLT = Input(Bool())
    val pCSel, regWEn, brUn, bSel, aSel, memRW, memUn, haltPC, eCall = Output(Bool())
    val aLUSel, call = Output(UInt(4.W))
    val immSel = Output(UInt(3.W))
    val wBSel, memWidth = Output(UInt(2.W))
  })

  // Default control word
  io.pCSel := PCAdd4
  io.regWEn := true.B
  io.brUn := false.B
  io.bSel := Brs2
  io.aSel := Ars1
  io.memRW := Read
  io.aLUSel := ADD
  io.immSel := type0Imm
  io.wBSel := aLU
  io.memUn := false.B
  io.memWidth := word
  io.haltPC := WireDefault(false.B)
  io.eCall := false.B
  io.call := WireDefault(0.U)

  // Combinatorial logic table
  switch(io.ctrl(4,0)){
    is(typeR){ // Instructions formatted as type R
      switch(io.ctrl(7,5)){

        is("b000".U){
          when(io.ctrl(8)){
            io.aLUSel := SUB
          }.otherwise{
            io.aLUSel := ADD
          }
        }

        is("b001".U){
          io.aLUSel := SLL
        }

        is("b010".U){
          io.aLUSel := SLT
        }

        is("b011".U){
          io.aLUSel := SLTU
        }

        is("b100".U){
          io.aLUSel := XOR
        }

        is("b101".U){
          when(io.ctrl(8)){
            io.aLUSel := SRA
          }.otherwise{
            io.aLUSel := SRL
          }
        }

        is("b110".U){
          io.aLUSel := OR
        }

        is("b111".U){
          io.aLUSel := AND
        }
      }
    }
    is(typeI1){ // Load instructions
      io.wBSel := mem
      io.bSel := BImm
      io.immSel := typeIImm
      switch(io.ctrl(7,5)){
        is("b000".U){ // LB
          io.memWidth := byte
        }
        is("b001".U){ // LH
          io.memWidth := hWord
        }
        is("b010".U){ // LW
          io.memWidth := word
        }
        is("b100".U){ // LBU
          io.memWidth := byte
          io.memUn := true.B
        }
        is("b101".U){ // LHU
          io.memWidth := hWord
          io.memUn := true.B
        }
      }
    }
    is(typeI2){ // Fence not implemented

    }
    is(typeI3){ // Imm arithmetic
      io.bSel := BImm
      io.immSel := typeIImm
      switch(io.ctrl(7,5)){

        is("b000".U){ // ADDI
          io.aLUSel := ADD
        }

        is("b010".U){ // SLTI
          io.aLUSel := SLT
        }

        is("b011".U){ // SLTIU
          io.aLUSel := SLTU
        }

        is("b100".U){ // XORI
          io.aLUSel := XOR
        }

        is("b110".U){ // ORI
          io.aLUSel := OR
        }

        is("b111".U){ // ANDI
          io.aLUSel := AND
        }

        is("b001".U){ // SLLI
          io.aLUSel := SLL
        }

        is("b101".U){
          when(io.ctrl(8)){ // SRAI
            io.aLUSel := SRA
          }. otherwise{ // SRLI
            io.aLUSel := SRL
          }
        }
      }
    }
    is(typeI4){ // Not used

    }
    is(typeI5){ // jalr
      io.pCSel := PCAddALU
      io.immSel := typeIImm
      io.bSel := BImm
      io.wBSel := pCPlus4
    }
    is(typeI6){ // Ecall
      io.eCall := true.B
      switch(io.a7){
        is(print_int){
          io.call := 0.U
        }
        is(print_float){
          io.call := 1.U
        }
        is(print_string){
          io.call := 2.U
        }
        is(exit){
          io.call := 3.U
          io.haltPC := true.B
        }
        is(print_char){
          io.call := 4.U
        }
        is(print_hex){
          io.call := 5.U
        }
        is(print_bin){
          io.call := 6.U
        }
        is(print_unsigned){
          io.call := 7.U
        }
        is(status_code){
          io.call := 8.U
          io.haltPC := true.B
        }
      }
    }
    is(typeS){ // Store instructions
      io.immSel := typeSImm
      io.bSel := BImm
      io.memRW := Write
      io.regWEn := false.B
      switch(io.ctrl(7,5)){
        is("b000".U){ // SB
          io.memWidth := byte
        }
        is("b001".U){ // SH
          io.memWidth := hWord
        }
        is("b010".U){ // SW
          io.memWidth := word
        }
      }
    }
    is(typeSB){ // Branch instructions
      switch(io.ctrl(7,5)){
        is("b000".U){ // BEQ
          io.immSel := typeBImm
          io.aSel := APC
          io.bSel := BImm
          io.regWEn := false.B
          when(io.brEq){ // Check branch
            io.pCSel := PCAddALU
          }
        }
        is("b001".U){ // BNE
          io.immSel := typeBImm
          io.aSel := APC
          io.bSel := BImm
          io.regWEn := false.B
          when(!io.brEq){ // Check branch
            io.pCSel := PCAddALU
          }
        }
        is("b100".U){ // BLT
          io.immSel := typeBImm
          io.aSel := APC
          io.bSel := BImm
          io.regWEn := false.B
          when(io.brLT){
            io.pCSel := PCAddALU
          }
        }
        is("b101".U){ // BGE
          io.immSel := typeBImm
          io.aSel := APC
          io.bSel := BImm
          io.regWEn := false.B
          when(io.brEq || !io.brLT){
            io.pCSel := PCAddALU
          }
        }
        is("b110".U){ // BLTU
          io.immSel := typeBImm
          io.aSel := APC
          io.bSel := BImm
          io.brUn := true.B
          io.regWEn := false.B
          when(io.brLT){
            io.pCSel := PCAddALU
          }
        }
        is("b111".U){ // BGEU
          io.immSel := typeBImm
          io.aSel := APC
          io.bSel := BImm
          io.brUn := true.B
          io.regWEn := false.B
          when(io.brEq || !io.brLT){
            io.pCSel := PCAddALU
          }
        }
      }
    }
    is(typeU1){ // LUI
      io.immSel := typeUImm
      io.bSel := BImm
    }
    is(typeU2){ // AUIPC instruction maybe not functional?
      io.immSel := typeUImm
      io.aSel := APC
      io.bSel := BImm
    }
    is(typeUJ){ // JAL
      io.immSel := typeUJImm
      io.pCSel := PCAddALU
      io.aSel := APC
      io.bSel := BImm
      io.wBSel := pCPlus4
    }
  }
}
