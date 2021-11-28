module BindsTo_0_InstructionMemory(
  input         clock,
  input  [31:0] io_address,
  output [31:0] io_instOut
);

initial begin
  $readmemh("Machine code.txt", InstructionMemory.instMem);
end
                      endmodule

bind InstructionMemory BindsTo_0_InstructionMemory BindsTo_0_InstructionMemory_Inst(.*);