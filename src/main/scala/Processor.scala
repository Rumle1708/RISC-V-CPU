import chisel3._

import java.io.File
import java.io.FileWriter
import java.io.FileInputStream

class Processor extends Module{
  val io = IO(new Bundle() {
    val haltOut = Output(Bool())
  })

  val programCounter = Module(new ProgramCounter)
  val instructionMemory = Module(new InstructionMemory)
  val instructionDecoder = Module(new InstructionDecoder)
  val registerBank = Module(new RegisterBank)
  val controlLogic = Module(new ControlLogic)
  val arithmeticLogicUnit = Module(new ALU)
  val immediateGenerator = Module(new ImmediateGenerator)
  val dataMemory = Module(new DataMemory)
  val writeBackSelector = Module(new WriteBackSelector)
  val branchComparator = Module(new BranchComparator)

  // Full data path

  // Program counter inputs
  programCounter.io.pCSel := controlLogic.io.pCSel
  programCounter.io.aLUIn := arithmeticLogicUnit.io.result
  programCounter.io.haltPC := controlLogic.io.haltPC

  // Instruction memory inputs
  instructionMemory.io.address := programCounter.io.pCOut >> 2.U

  // Instruction decoder inputs
  instructionDecoder.io.inst := instructionMemory.io.instOut

  // Register bank inputs
  registerBank.io.rd := instructionDecoder.io.rd
  registerBank.io.rs1 := instructionDecoder.io.rs1
  registerBank.io.rs2 := instructionDecoder.io.rs2
  registerBank.io.dataIn := writeBackSelector.io.wBOut
  registerBank.io.regWrite := controlLogic.io.regWEn
  registerBank.io.call := controlLogic.io.call
  registerBank.io.eCall := controlLogic.io.eCall

  // Control logic inputs
  controlLogic.io.ctrl := instructionDecoder.io.ctrl
  controlLogic.io.brEq := branchComparator.io.brEq
  controlLogic.io.brLT := branchComparator.io.brLT
  controlLogic.io.a7 := registerBank.io.a7

  // ALU inputs
  arithmeticLogicUnit.io.dataA := registerBank.io.dataA
  arithmeticLogicUnit.io.dataB := registerBank.io.dataB
  arithmeticLogicUnit.io.aSel := controlLogic.io.aSel
  arithmeticLogicUnit.io.bSel := controlLogic.io.bSel
  arithmeticLogicUnit.io.aLUSel := controlLogic.io.aLUSel
  arithmeticLogicUnit.io.pCIn := programCounter.io.pCOut
  arithmeticLogicUnit.io.immIn := immediateGenerator.io.immOut

  // ImmGen inputs
  immediateGenerator.io.immIn := instructionDecoder.io.imm
  immediateGenerator.io.immSel := controlLogic.io.immSel

  // Data memory inputs
  dataMemory.io.dataIn := registerBank.io.dataB
  dataMemory.io.address := arithmeticLogicUnit.io.result
  dataMemory.io.memRW := controlLogic.io.memRW
  dataMemory.io.memUn := controlLogic.io.memUn
  dataMemory.io.memWidth := controlLogic.io.memWidth

  // Write back selector inputs
  writeBackSelector.io.memIn := dataMemory.io.dataOut
  writeBackSelector.io.aLUIn := arithmeticLogicUnit.io.result
  writeBackSelector.io.pCplus4 := programCounter.io.pCPlus4
  writeBackSelector.io.wBSel := controlLogic.io.wBSel

  // Branch comparator inputs
  branchComparator.io.dataA := registerBank.io.dataA
  branchComparator.io.dataB := registerBank.io.dataB
  branchComparator.io.brUn := controlLogic.io.brUn

  //printf(p"PC = 0x${Hexadecimal(programCounter.io.pCOut)}")
  //printf(p"\tInst = 0x${Hexadecimal(instructionMemory.io.instOut)} \n")

  // Output for tester
  io.haltOut := controlLogic.io.haltPC
}

object Processor extends App {
  // Set program file here:
  val filePath = "task5/Prime.bin" // Edit program here

  // Read program and interpret as int array
  var fIS = new FileInputStream(filePath)
  var fileSize = fIS.available()
  println("Input file size: " + fileSize + " bytes")
  var temp = new Array[Int](4)
  var inst = new Array[Int](fIS.available()/4)

  for (j <- 0 until inst.length) {
    for (i <- 0 until temp.length) {
      temp(i) = fIS.read() << (i * 8)
    }
    inst(j) = temp(0) + temp (1) + temp(2) + temp(3)

    // Print program to console
    print("Machine code 0x")
    print(String.format("%2s", (4*j).toHexString).replaceAll(" ", "0"))
    println(": 0x" + String.format("%8s", inst(j).toHexString).replaceAll(" ", "0"))
  }
  fIS.close()

  // Setup file writer
  def writeFile(fileName: String, content: String) {
    if(fileName != null && !fileName.isEmpty()) {
      var file = new File(fileName);
      var fileWriter = new FileWriter(file);
      fileWriter.write(content);
      fileWriter.close();
    }
  }

  // Write program to .txt file (used in InstructionMemory.scala)
  var s = ""
  for (j <- 0 until inst.length) {
    s += inst(j).toHexString.replaceAll(" ", "0") + "\n"
  }
  writeFile("Machine code.txt", s)

  // Generate verilog
  println("Generating hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new Processor())
  println("Hardware successfully generated")
}
