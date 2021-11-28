
import chisel3._
import chisel3.iotesters.Driver
import chisel3.iotesters.PeekPokeTester
import org.scalatest._

class ProcessorTester(dut: Processor) extends PeekPokeTester(dut){
  var stop = false
  var i = 0
  val maxCycles = 60000 // Set maximum cycles for test
  while(!stop && i < maxCycles){
    step(1)
    stop = peek(dut.io.haltOut) == 1
    i = i + 1
  }
  step(1) // Run ECALL
}

class ProcessorSpec extends FlatSpec with Matchers{
  "Processor" should "pass" in{
    Driver.execute(Array[String](), () => new Processor()) {
      c => new ProcessorTester(c)
    }should be (true)
  }
}