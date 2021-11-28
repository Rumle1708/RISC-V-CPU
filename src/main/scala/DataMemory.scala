import chisel3._
import chisel3.util._

import DataMemory._

object DataMemory {
  val byte = "b00".U
  val hWord = "b01".U
  val word = "b10".U
}

class DataMemory extends Module{
  val io = IO(new Bundle{
    val address, dataIn = Input(UInt(32.W))
    val memRW, memUn = Input(Bool())
    val memWidth = Input(UInt(2.W))
    val dataOut = Output(UInt(32.W))
  })
  val dataMem = Mem(1048576 * 2, UInt(8.W))

  io.dataOut := WireDefault(0.U)

  // Store
  when(io.memRW){
    switch(io.memWidth){
      is(byte){ // SB
        dataMem.write(io.address, io.dataIn(7,0))
      }
      is(hWord){ // SH
        dataMem.write(io.address, io.dataIn(7,0))
        dataMem.write(io.address + 1.U, io.dataIn(15,8))
      }
      is(word){ // SW
        dataMem.write(io.address, io.dataIn(7,0))
        dataMem.write(io.address + 1.U, io.dataIn(15,8))
        dataMem.write(io.address + 2.U, io.dataIn(23,16))
        dataMem.write(io.address + 3.U, io.dataIn(31,24))
      }
    }
  }

  // Load
  switch(io.memWidth){
    is(byte){
      when(io.memUn){ // LBU
        io.dataOut := dataMem.read(io.address)
      }. otherwise{ // LB
        io.dataOut := Cat(Fill(24,dataMem.read(io.address)(7)),dataMem.read(io.address))
      }
    }
    is(hWord){
      when(io.memUn){ // LHU
        io.dataOut := Cat(dataMem.read(io.address + 1.U), dataMem.read(io.address))
      }. otherwise{ // LH
        io.dataOut := Cat(Fill(16,dataMem.read(io.address + 1.U)(7)),Cat(dataMem.read(io.address + 1.U), dataMem.read(io.address)))
      }
    }
    is(word){ // LW
      io.dataOut := Cat(dataMem.read(io.address + 3.U),dataMem.read(io.address + 2.U),dataMem.read(io.address + 1.U),dataMem.read(io.address))
    }
  }
}