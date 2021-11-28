module ProgramCounter(
  input         clock,
  input         reset,
  input         io_pCSel,
  input         io_haltPC,
  input  [31:0] io_aLUIn,
  output [31:0] io_pCOut,
  output [31:0] io_pCPlus4
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] counter; // @[ProgramCounter.scala 11:24]
  wire [31:0] _T_3 = counter + 32'h4; // @[ProgramCounter.scala 15:26]
  assign io_pCOut = counter; // @[ProgramCounter.scala 20:12]
  assign io_pCPlus4 = counter + 32'h4; // @[ProgramCounter.scala 21:25]
  always @(posedge clock) begin
    if (reset) begin // @[ProgramCounter.scala 11:24]
      counter <= 32'h0; // @[ProgramCounter.scala 11:24]
    end else if (~io_haltPC) begin // @[ProgramCounter.scala 13:19]
      if (~io_pCSel) begin // @[ProgramCounter.scala 14:20]
        counter <= _T_3; // @[ProgramCounter.scala 15:15]
      end else begin
        counter <= io_aLUIn; // @[ProgramCounter.scala 17:15]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  counter = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InstructionMemory(
  input         clock,
  input  [31:0] io_address,
  output [31:0] io_instOut
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] instMem [0:4095]; // @[InstructionMemory.scala 9:20]
  wire [31:0] instMem_MPORT_data; // @[InstructionMemory.scala 9:20]
  wire [11:0] instMem_MPORT_addr; // @[InstructionMemory.scala 9:20]
  assign instMem_MPORT_addr = io_address[11:0];
  assign instMem_MPORT_data = instMem[instMem_MPORT_addr]; // @[InstructionMemory.scala 9:20]
  assign io_instOut = instMem_MPORT_data; // @[InstructionMemory.scala 10:14]
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    instMem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InstructionDecoder(
  input  [31:0] io_inst,
  output [4:0]  io_rd,
  output [4:0]  io_rs1,
  output [4:0]  io_rs2,
  output [24:0] io_imm,
  output [8:0]  io_ctrl
);
  wire  hi_hi = io_inst[30]; // @[InstructionDecoder.scala 16:25]
  wire [2:0] hi_lo = io_inst[14:12]; // @[InstructionDecoder.scala 16:38]
  wire [4:0] lo = io_inst[6:2]; // @[InstructionDecoder.scala 16:54]
  wire [3:0] hi = {hi_hi,hi_lo}; // @[Cat.scala 30:58]
  assign io_rd = io_inst[11:7]; // @[InstructionDecoder.scala 12:19]
  assign io_rs1 = io_inst[19:15]; // @[InstructionDecoder.scala 13:20]
  assign io_rs2 = io_inst[24:20]; // @[InstructionDecoder.scala 14:20]
  assign io_imm = io_inst[31:7]; // @[InstructionDecoder.scala 15:20]
  assign io_ctrl = {hi,lo}; // @[Cat.scala 30:58]
endmodule
module RegisterBank(
  input         clock,
  input         reset,
  output [31:0] io_dataA,
  output [31:0] io_dataB,
  output [31:0] io_a7,
  input  [4:0]  io_rd,
  input  [4:0]  io_rs1,
  input  [4:0]  io_rs2,
  input  [31:0] io_dataIn,
  input         io_regWrite,
  input         io_eCall,
  input  [3:0]  io_call
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] x_0; // @[RegisterBank.scala 13:14]
  reg [31:0] x_1; // @[RegisterBank.scala 13:14]
  reg [31:0] x_2; // @[RegisterBank.scala 13:14]
  reg [31:0] x_3; // @[RegisterBank.scala 13:14]
  reg [31:0] x_4; // @[RegisterBank.scala 13:14]
  reg [31:0] x_5; // @[RegisterBank.scala 13:14]
  reg [31:0] x_6; // @[RegisterBank.scala 13:14]
  reg [31:0] x_7; // @[RegisterBank.scala 13:14]
  reg [31:0] x_8; // @[RegisterBank.scala 13:14]
  reg [31:0] x_9; // @[RegisterBank.scala 13:14]
  reg [31:0] x_10; // @[RegisterBank.scala 13:14]
  reg [31:0] x_11; // @[RegisterBank.scala 13:14]
  reg [31:0] x_12; // @[RegisterBank.scala 13:14]
  reg [31:0] x_13; // @[RegisterBank.scala 13:14]
  reg [31:0] x_14; // @[RegisterBank.scala 13:14]
  reg [31:0] x_15; // @[RegisterBank.scala 13:14]
  reg [31:0] x_16; // @[RegisterBank.scala 13:14]
  reg [31:0] x_17; // @[RegisterBank.scala 13:14]
  reg [31:0] x_18; // @[RegisterBank.scala 13:14]
  reg [31:0] x_19; // @[RegisterBank.scala 13:14]
  reg [31:0] x_20; // @[RegisterBank.scala 13:14]
  reg [31:0] x_21; // @[RegisterBank.scala 13:14]
  reg [31:0] x_22; // @[RegisterBank.scala 13:14]
  reg [31:0] x_23; // @[RegisterBank.scala 13:14]
  reg [31:0] x_24; // @[RegisterBank.scala 13:14]
  reg [31:0] x_25; // @[RegisterBank.scala 13:14]
  reg [31:0] x_26; // @[RegisterBank.scala 13:14]
  reg [31:0] x_27; // @[RegisterBank.scala 13:14]
  reg [31:0] x_28; // @[RegisterBank.scala 13:14]
  reg [31:0] x_29; // @[RegisterBank.scala 13:14]
  reg [31:0] x_30; // @[RegisterBank.scala 13:14]
  reg [31:0] x_31; // @[RegisterBank.scala 13:14]
  wire [31:0] _GEN_1 = 5'h1 == io_rs1 ? x_1 : x_0; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_2 = 5'h2 == io_rs1 ? x_2 : _GEN_1; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_3 = 5'h3 == io_rs1 ? x_3 : _GEN_2; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_4 = 5'h4 == io_rs1 ? x_4 : _GEN_3; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_5 = 5'h5 == io_rs1 ? x_5 : _GEN_4; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_6 = 5'h6 == io_rs1 ? x_6 : _GEN_5; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_7 = 5'h7 == io_rs1 ? x_7 : _GEN_6; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_8 = 5'h8 == io_rs1 ? x_8 : _GEN_7; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_9 = 5'h9 == io_rs1 ? x_9 : _GEN_8; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_10 = 5'ha == io_rs1 ? x_10 : _GEN_9; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_11 = 5'hb == io_rs1 ? x_11 : _GEN_10; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_12 = 5'hc == io_rs1 ? x_12 : _GEN_11; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_13 = 5'hd == io_rs1 ? x_13 : _GEN_12; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_14 = 5'he == io_rs1 ? x_14 : _GEN_13; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_15 = 5'hf == io_rs1 ? x_15 : _GEN_14; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_16 = 5'h10 == io_rs1 ? x_16 : _GEN_15; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_17 = 5'h11 == io_rs1 ? x_17 : _GEN_16; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_18 = 5'h12 == io_rs1 ? x_18 : _GEN_17; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_19 = 5'h13 == io_rs1 ? x_19 : _GEN_18; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_20 = 5'h14 == io_rs1 ? x_20 : _GEN_19; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_21 = 5'h15 == io_rs1 ? x_21 : _GEN_20; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_22 = 5'h16 == io_rs1 ? x_22 : _GEN_21; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_23 = 5'h17 == io_rs1 ? x_23 : _GEN_22; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_24 = 5'h18 == io_rs1 ? x_24 : _GEN_23; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_25 = 5'h19 == io_rs1 ? x_25 : _GEN_24; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_26 = 5'h1a == io_rs1 ? x_26 : _GEN_25; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_27 = 5'h1b == io_rs1 ? x_27 : _GEN_26; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_28 = 5'h1c == io_rs1 ? x_28 : _GEN_27; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_29 = 5'h1d == io_rs1 ? x_29 : _GEN_28; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_30 = 5'h1e == io_rs1 ? x_30 : _GEN_29; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  wire [31:0] _GEN_33 = 5'h1 == io_rs2 ? x_1 : x_0; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_34 = 5'h2 == io_rs2 ? x_2 : _GEN_33; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_35 = 5'h3 == io_rs2 ? x_3 : _GEN_34; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_36 = 5'h4 == io_rs2 ? x_4 : _GEN_35; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_37 = 5'h5 == io_rs2 ? x_5 : _GEN_36; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_38 = 5'h6 == io_rs2 ? x_6 : _GEN_37; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_39 = 5'h7 == io_rs2 ? x_7 : _GEN_38; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_40 = 5'h8 == io_rs2 ? x_8 : _GEN_39; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_41 = 5'h9 == io_rs2 ? x_9 : _GEN_40; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_42 = 5'ha == io_rs2 ? x_10 : _GEN_41; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_43 = 5'hb == io_rs2 ? x_11 : _GEN_42; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_44 = 5'hc == io_rs2 ? x_12 : _GEN_43; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_45 = 5'hd == io_rs2 ? x_13 : _GEN_44; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_46 = 5'he == io_rs2 ? x_14 : _GEN_45; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_47 = 5'hf == io_rs2 ? x_15 : _GEN_46; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_48 = 5'h10 == io_rs2 ? x_16 : _GEN_47; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_49 = 5'h11 == io_rs2 ? x_17 : _GEN_48; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_50 = 5'h12 == io_rs2 ? x_18 : _GEN_49; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_51 = 5'h13 == io_rs2 ? x_19 : _GEN_50; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_52 = 5'h14 == io_rs2 ? x_20 : _GEN_51; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_53 = 5'h15 == io_rs2 ? x_21 : _GEN_52; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_54 = 5'h16 == io_rs2 ? x_22 : _GEN_53; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_55 = 5'h17 == io_rs2 ? x_23 : _GEN_54; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_56 = 5'h18 == io_rs2 ? x_24 : _GEN_55; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_57 = 5'h19 == io_rs2 ? x_25 : _GEN_56; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_58 = 5'h1a == io_rs2 ? x_26 : _GEN_57; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_59 = 5'h1b == io_rs2 ? x_27 : _GEN_58; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_60 = 5'h1c == io_rs2 ? x_28 : _GEN_59; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_61 = 5'h1d == io_rs2 ? x_29 : _GEN_60; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire [31:0] _GEN_62 = 5'h1e == io_rs2 ? x_30 : _GEN_61; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  wire  _T_2 = 4'h0 == io_call; // @[Conditional.scala 37:30]
  wire  _T_5 = ~reset; // @[RegisterBank.scala 33:15]
  wire  _T_6 = 4'h1 == io_call; // @[Conditional.scala 37:30]
  wire  _T_9 = 4'h2 == io_call; // @[Conditional.scala 37:30]
  wire  _T_10 = 4'h3 == io_call; // @[Conditional.scala 37:30]
  wire  _T_161 = 4'h4 == io_call; // @[Conditional.scala 37:30]
  wire  _T_164 = 4'h5 == io_call; // @[Conditional.scala 37:30]
  wire  _T_167 = 4'h6 == io_call; // @[Conditional.scala 37:30]
  wire  _T_170 = 4'h7 == io_call; // @[Conditional.scala 37:30]
  wire  _T_173 = 4'h8 == io_call; // @[Conditional.scala 37:30]
  wire  _GEN_130 = io_eCall & ~_T_2; // @[RegisterBank.scala 36:15]
  wire  _GEN_137 = _GEN_130 & ~_T_6 & ~_T_9; // @[RegisterBank.scala 44:19]
  wire  _GEN_138 = _GEN_130 & ~_T_6 & ~_T_9 & _T_10; // @[RegisterBank.scala 44:19]
  wire  _GEN_664 = _GEN_137 & ~_T_10; // @[RegisterBank.scala 55:15]
  wire  _GEN_675 = _GEN_664 & ~_T_161; // @[RegisterBank.scala 58:15]
  wire  _GEN_688 = _GEN_675 & ~_T_164; // @[RegisterBank.scala 61:15]
  wire  _GEN_703 = _GEN_688 & ~_T_167; // @[RegisterBank.scala 64:15]
  assign io_dataA = 5'h1f == io_rs1 ? x_31 : _GEN_30; // @[RegisterBank.scala 18:12 RegisterBank.scala 18:12]
  assign io_dataB = 5'h1f == io_rs2 ? x_31 : _GEN_62; // @[RegisterBank.scala 19:12 RegisterBank.scala 19:12]
  assign io_a7 = x_17; // @[RegisterBank.scala 22:9]
  always @(posedge clock) begin
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h0 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_0 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end else begin
        x_0 <= 32'h0; // @[RegisterBank.scala 15:8]
      end
    end else begin
      x_0 <= 32'h0; // @[RegisterBank.scala 15:8]
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h1 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_1 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h2 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_2 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h3 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_3 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h4 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_4 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h5 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_5 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h6 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_6 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h7 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_7 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h8 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_8 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h9 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_9 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'ha == io_rd) begin // @[RegisterBank.scala 26:14]
        x_10 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'hb == io_rd) begin // @[RegisterBank.scala 26:14]
        x_11 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'hc == io_rd) begin // @[RegisterBank.scala 26:14]
        x_12 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'hd == io_rd) begin // @[RegisterBank.scala 26:14]
        x_13 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'he == io_rd) begin // @[RegisterBank.scala 26:14]
        x_14 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'hf == io_rd) begin // @[RegisterBank.scala 26:14]
        x_15 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h10 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_16 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h11 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_17 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h12 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_18 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h13 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_19 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h14 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_20 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h15 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_21 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h16 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_22 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h17 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_23 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h18 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_24 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h19 == io_rd) begin // @[RegisterBank.scala 26:14]
        x_25 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h1a == io_rd) begin // @[RegisterBank.scala 26:14]
        x_26 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h1b == io_rd) begin // @[RegisterBank.scala 26:14]
        x_27 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h1c == io_rd) begin // @[RegisterBank.scala 26:14]
        x_28 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h1d == io_rd) begin // @[RegisterBank.scala 26:14]
        x_29 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h1e == io_rd) begin // @[RegisterBank.scala 26:14]
        x_30 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    if (io_regWrite & io_rd != 5'h0) begin // @[RegisterBank.scala 24:37]
      if (5'h1f == io_rd) begin // @[RegisterBank.scala 26:14]
        x_31 <= io_dataIn; // @[RegisterBank.scala 26:14]
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_eCall & _T_2 & ~reset) begin
          $fwrite(32'h80000002,"%d",x_10); // @[RegisterBank.scala 33:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_eCall & ~_T_2 & _T_6 & _T_5) begin
          $fwrite(32'h80000002,"%d.00",x_10); // @[RegisterBank.scala 36:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(0)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_0); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(8)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," "); // @[RegisterBank.scala 46:21]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_8); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(16)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_16); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(24)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_24); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002,"\n"); // @[RegisterBank.scala 50:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(1)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_1); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(9)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," "); // @[RegisterBank.scala 46:21]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_9); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(17)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_17); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(25)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_25); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002,"\n"); // @[RegisterBank.scala 50:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(2)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_2); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(10)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_10); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(18)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_18); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(26)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_26); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002,"\n"); // @[RegisterBank.scala 50:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(3)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_3); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(11)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_11); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(19)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_19); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(27)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_27); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002,"\n"); // @[RegisterBank.scala 50:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(4)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_4); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(12)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_12); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(20)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_20); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(28)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_28); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002,"\n"); // @[RegisterBank.scala 50:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(5)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_5); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(13)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_13); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(21)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_21); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(29)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_29); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002,"\n"); // @[RegisterBank.scala 50:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(6)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_6); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(14)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_14); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(22)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_22); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(30)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_30); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002,"\n"); // @[RegisterBank.scala 50:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(7)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_7); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(15)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_15); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(23)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_23); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_130 & ~_T_6 & ~_T_9 & _T_10 & _T_5) begin
          $fwrite(32'h80000002,"x(31)"); // @[RegisterBank.scala 44:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002," = 0x%x\t",x_31); // @[RegisterBank.scala 48:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002,"\n"); // @[RegisterBank.scala 50:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_138 & _T_5) begin
          $fwrite(32'h80000002,"\n\n"); // @[RegisterBank.scala 52:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_137 & ~_T_10 & _T_161 & _T_5) begin
          $fwrite(32'h80000002,"%c",x_10); // @[RegisterBank.scala 55:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_664 & ~_T_161 & _T_164 & _T_5) begin
          $fwrite(32'h80000002,"%x",x_10); // @[RegisterBank.scala 58:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_675 & ~_T_164 & _T_167 & _T_5) begin
          $fwrite(32'h80000002,"%b",x_10); // @[RegisterBank.scala 61:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_688 & ~_T_167 & _T_170 & _T_5) begin
          $fwrite(32'h80000002,"%d",x_10); // @[RegisterBank.scala 64:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_703 & ~_T_170 & _T_173 & _T_5) begin
          $fwrite(32'h80000002,"Status code: %d",x_10); // @[RegisterBank.scala 67:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  x_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  x_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  x_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  x_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  x_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  x_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  x_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  x_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  x_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  x_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  x_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  x_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  x_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  x_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  x_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  x_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  x_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  x_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  x_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  x_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  x_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  x_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  x_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  x_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  x_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  x_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  x_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  x_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  x_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  x_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  x_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  x_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ControlLogic(
  input  [8:0]  io_ctrl,
  input  [31:0] io_a7,
  input         io_brEq,
  input         io_brLT,
  output        io_pCSel,
  output        io_regWEn,
  output        io_brUn,
  output        io_bSel,
  output        io_aSel,
  output        io_memRW,
  output        io_memUn,
  output        io_haltPC,
  output        io_eCall,
  output [3:0]  io_aLUSel,
  output [3:0]  io_call,
  output [2:0]  io_immSel,
  output [1:0]  io_wBSel,
  output [1:0]  io_memWidth
);
  wire  _T_1 = 5'hc == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire  _T_3 = 3'h0 == io_ctrl[7:5]; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_0 = io_ctrl[8] ? 4'h1 : 4'h0; // @[ControlLogic.scala 109:27 ControlLogic.scala 110:23 ControlLogic.scala 112:23]
  wire  _T_5 = 3'h1 == io_ctrl[7:5]; // @[Conditional.scala 37:30]
  wire  _T_6 = 3'h2 == io_ctrl[7:5]; // @[Conditional.scala 37:30]
  wire  _T_7 = 3'h3 == io_ctrl[7:5]; // @[Conditional.scala 37:30]
  wire  _T_8 = 3'h4 == io_ctrl[7:5]; // @[Conditional.scala 37:30]
  wire  _T_9 = 3'h5 == io_ctrl[7:5]; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_1 = io_ctrl[8] ? 4'h9 : 4'h8; // @[ControlLogic.scala 133:27 ControlLogic.scala 134:23 ControlLogic.scala 136:23]
  wire  _T_11 = 3'h6 == io_ctrl[7:5]; // @[Conditional.scala 37:30]
  wire  _T_12 = 3'h7 == io_ctrl[7:5]; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_2 = _T_12 ? 4'h2 : 4'h0; // @[Conditional.scala 39:67 ControlLogic.scala 145:21 ControlLogic.scala 94:13]
  wire [3:0] _GEN_3 = _T_11 ? 4'h3 : _GEN_2; // @[Conditional.scala 39:67 ControlLogic.scala 141:21]
  wire [3:0] _GEN_4 = _T_9 ? _GEN_1 : _GEN_3; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_5 = _T_8 ? 4'h4 : _GEN_4; // @[Conditional.scala 39:67 ControlLogic.scala 129:21]
  wire [3:0] _GEN_6 = _T_7 ? 4'h7 : _GEN_5; // @[Conditional.scala 39:67 ControlLogic.scala 125:21]
  wire [3:0] _GEN_7 = _T_6 ? 4'h5 : _GEN_6; // @[Conditional.scala 39:67 ControlLogic.scala 121:21]
  wire [3:0] _GEN_8 = _T_5 ? 4'h6 : _GEN_7; // @[Conditional.scala 39:67 ControlLogic.scala 117:21]
  wire [3:0] _GEN_9 = _T_3 ? _GEN_0 : _GEN_8; // @[Conditional.scala 40:58]
  wire  _T_13 = 5'h0 == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_10 = _T_9 ? 2'h1 : 2'h2; // @[Conditional.scala 39:67 ControlLogic.scala 168:23 ControlLogic.scala 98:15]
  wire [1:0] _GEN_12 = _T_8 ? 2'h0 : _GEN_10; // @[Conditional.scala 39:67 ControlLogic.scala 164:23]
  wire  _GEN_13 = _T_8 | _T_9; // @[Conditional.scala 39:67 ControlLogic.scala 165:20]
  wire [1:0] _GEN_14 = _T_6 ? 2'h2 : _GEN_12; // @[Conditional.scala 39:67 ControlLogic.scala 161:23]
  wire  _GEN_15 = _T_6 ? 1'h0 : _GEN_13; // @[Conditional.scala 39:67 ControlLogic.scala 97:12]
  wire [1:0] _GEN_16 = _T_5 ? 2'h1 : _GEN_14; // @[Conditional.scala 39:67 ControlLogic.scala 158:23]
  wire  _GEN_17 = _T_5 ? 1'h0 : _GEN_15; // @[Conditional.scala 39:67 ControlLogic.scala 97:12]
  wire [1:0] _GEN_18 = _T_3 ? 2'h0 : _GEN_16; // @[Conditional.scala 40:58 ControlLogic.scala 155:23]
  wire  _GEN_19 = _T_3 ? 1'h0 : _GEN_17; // @[Conditional.scala 40:58 ControlLogic.scala 97:12]
  wire  _T_20 = 5'h3 == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire  _T_21 = 5'h4 == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_21 = _T_9 ? _GEN_1 : 4'h0; // @[Conditional.scala 39:67 ControlLogic.scala 94:13]
  wire [3:0] _GEN_22 = _T_5 ? 4'h6 : _GEN_21; // @[Conditional.scala 39:67 ControlLogic.scala 206:21]
  wire [3:0] _GEN_23 = _T_12 ? 4'h2 : _GEN_22; // @[Conditional.scala 39:67 ControlLogic.scala 202:21]
  wire [3:0] _GEN_24 = _T_11 ? 4'h3 : _GEN_23; // @[Conditional.scala 39:67 ControlLogic.scala 198:21]
  wire [3:0] _GEN_25 = _T_8 ? 4'h4 : _GEN_24; // @[Conditional.scala 39:67 ControlLogic.scala 194:21]
  wire [3:0] _GEN_26 = _T_7 ? 4'h7 : _GEN_25; // @[Conditional.scala 39:67 ControlLogic.scala 190:21]
  wire [3:0] _GEN_27 = _T_6 ? 4'h5 : _GEN_26; // @[Conditional.scala 39:67 ControlLogic.scala 186:21]
  wire [3:0] _GEN_28 = _T_3 ? 4'h0 : _GEN_27; // @[Conditional.scala 40:58 ControlLogic.scala 182:21]
  wire  _T_32 = 5'h6 == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire  _T_33 = 5'h19 == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire  _T_34 = 5'h1c == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire  _T_35 = 32'h1 == io_a7; // @[Conditional.scala 37:30]
  wire  _T_36 = 32'h2 == io_a7; // @[Conditional.scala 37:30]
  wire  _T_37 = 32'h4 == io_a7; // @[Conditional.scala 37:30]
  wire  _T_38 = 32'ha == io_a7; // @[Conditional.scala 37:30]
  wire  _T_39 = 32'hb == io_a7; // @[Conditional.scala 37:30]
  wire  _T_40 = 32'h22 == io_a7; // @[Conditional.scala 37:30]
  wire  _T_41 = 32'h23 == io_a7; // @[Conditional.scala 37:30]
  wire  _T_42 = 32'h24 == io_a7; // @[Conditional.scala 37:30]
  wire  _T_43 = 32'h5d == io_a7; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_29 = _T_43 ? 4'h8 : 4'h0; // @[Conditional.scala 39:67 ControlLogic.scala 256:19 ControlLogic.scala 101:11]
  wire [3:0] _GEN_31 = _T_42 ? 4'h7 : _GEN_29; // @[Conditional.scala 39:67 ControlLogic.scala 253:19]
  wire  _GEN_32 = _T_42 ? 1'h0 : _T_43; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire [3:0] _GEN_33 = _T_41 ? 4'h6 : _GEN_31; // @[Conditional.scala 39:67 ControlLogic.scala 250:19]
  wire  _GEN_34 = _T_41 ? 1'h0 : _GEN_32; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire [3:0] _GEN_35 = _T_40 ? 4'h5 : _GEN_33; // @[Conditional.scala 39:67 ControlLogic.scala 247:19]
  wire  _GEN_36 = _T_40 ? 1'h0 : _GEN_34; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire [3:0] _GEN_37 = _T_39 ? 4'h4 : _GEN_35; // @[Conditional.scala 39:67 ControlLogic.scala 244:19]
  wire  _GEN_38 = _T_39 ? 1'h0 : _GEN_36; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire [3:0] _GEN_39 = _T_38 ? 4'h3 : _GEN_37; // @[Conditional.scala 39:67 ControlLogic.scala 240:19]
  wire  _GEN_40 = _T_38 | _GEN_38; // @[Conditional.scala 39:67 ControlLogic.scala 241:21]
  wire [3:0] _GEN_41 = _T_37 ? 4'h2 : _GEN_39; // @[Conditional.scala 39:67 ControlLogic.scala 237:19]
  wire  _GEN_42 = _T_37 ? 1'h0 : _GEN_40; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire [3:0] _GEN_43 = _T_36 ? 4'h1 : _GEN_41; // @[Conditional.scala 39:67 ControlLogic.scala 234:19]
  wire  _GEN_44 = _T_36 ? 1'h0 : _GEN_42; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire [3:0] _GEN_45 = _T_35 ? 4'h0 : _GEN_43; // @[Conditional.scala 40:58 ControlLogic.scala 231:19]
  wire  _GEN_46 = _T_35 ? 1'h0 : _GEN_44; // @[Conditional.scala 40:58 ControlLogic.scala 99:13]
  wire  _T_44 = 5'h8 == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_48 = _T_5 ? 2'h1 : 2'h2; // @[Conditional.scala 39:67 ControlLogic.scala 271:23]
  wire [1:0] _GEN_49 = _T_3 ? 2'h0 : _GEN_48; // @[Conditional.scala 40:58 ControlLogic.scala 268:23]
  wire  _T_49 = 5'h18 == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire  _T_53 = ~io_brEq; // @[ControlLogic.scala 294:16]
  wire  _T_57 = io_brEq | ~io_brLT; // @[ControlLogic.scala 312:24]
  wire [2:0] _GEN_55 = _T_12 ? 3'h5 : 3'h0; // @[Conditional.scala 39:67 ControlLogic.scala 327:21 ControlLogic.scala 95:13]
  wire  _GEN_57 = _T_12 ? 1'h0 : 1'h1; // @[Conditional.scala 39:67 ControlLogic.scala 331:21 ControlLogic.scala 89:13]
  wire  _GEN_58 = _T_12 & _T_57; // @[Conditional.scala 39:67 ControlLogic.scala 88:12]
  wire [2:0] _GEN_59 = _T_11 ? 3'h5 : _GEN_55; // @[Conditional.scala 39:67 ControlLogic.scala 317:21]
  wire  _GEN_60 = _T_11 | _T_12; // @[Conditional.scala 39:67 ControlLogic.scala 318:19]
  wire  _GEN_61 = _T_11 ? 1'h0 : _GEN_57; // @[Conditional.scala 39:67 ControlLogic.scala 321:21]
  wire  _GEN_62 = _T_11 ? io_brLT : _GEN_58; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_63 = _T_9 ? 3'h5 : _GEN_59; // @[Conditional.scala 39:67 ControlLogic.scala 308:21]
  wire  _GEN_64 = _T_9 | _GEN_60; // @[Conditional.scala 39:67 ControlLogic.scala 309:19]
  wire  _GEN_65 = _T_9 ? 1'h0 : _GEN_61; // @[Conditional.scala 39:67 ControlLogic.scala 311:21]
  wire  _GEN_66 = _T_9 ? _T_57 : _GEN_62; // @[Conditional.scala 39:67]
  wire  _GEN_67 = _T_9 ? 1'h0 : _GEN_60; // @[Conditional.scala 39:67 ControlLogic.scala 90:11]
  wire [2:0] _GEN_68 = _T_8 ? 3'h5 : _GEN_63; // @[Conditional.scala 39:67 ControlLogic.scala 299:21]
  wire  _GEN_69 = _T_8 | _GEN_64; // @[Conditional.scala 39:67 ControlLogic.scala 300:19]
  wire  _GEN_70 = _T_8 ? 1'h0 : _GEN_65; // @[Conditional.scala 39:67 ControlLogic.scala 302:21]
  wire  _GEN_71 = _T_8 ? io_brLT : _GEN_66; // @[Conditional.scala 39:67]
  wire  _GEN_72 = _T_8 ? 1'h0 : _GEN_67; // @[Conditional.scala 39:67 ControlLogic.scala 90:11]
  wire [2:0] _GEN_73 = _T_5 ? 3'h5 : _GEN_68; // @[Conditional.scala 39:67 ControlLogic.scala 290:21]
  wire  _GEN_74 = _T_5 | _GEN_69; // @[Conditional.scala 39:67 ControlLogic.scala 291:19]
  wire  _GEN_75 = _T_5 ? 1'h0 : _GEN_70; // @[Conditional.scala 39:67 ControlLogic.scala 293:21]
  wire  _GEN_76 = _T_5 ? _T_53 : _GEN_71; // @[Conditional.scala 39:67]
  wire  _GEN_77 = _T_5 ? 1'h0 : _GEN_72; // @[Conditional.scala 39:67 ControlLogic.scala 90:11]
  wire [2:0] _GEN_78 = _T_3 ? 3'h5 : _GEN_73; // @[Conditional.scala 40:58 ControlLogic.scala 281:21]
  wire  _GEN_79 = _T_3 | _GEN_74; // @[Conditional.scala 40:58 ControlLogic.scala 282:19]
  wire  _GEN_80 = _T_3 ? 1'h0 : _GEN_75; // @[Conditional.scala 40:58 ControlLogic.scala 284:21]
  wire  _GEN_81 = _T_3 ? io_brEq : _GEN_76; // @[Conditional.scala 40:58]
  wire  _GEN_82 = _T_3 ? 1'h0 : _GEN_77; // @[Conditional.scala 40:58 ControlLogic.scala 90:11]
  wire  _T_62 = 5'hd == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire  _T_63 = 5'h5 == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire  _T_64 = 5'h1b == io_ctrl[4:0]; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_83 = _T_64 ? 3'h4 : 3'h0; // @[Conditional.scala 39:67 ControlLogic.scala 348:17 ControlLogic.scala 95:13]
  wire [1:0] _GEN_85 = _T_64 ? 2'h2 : 2'h1; // @[Conditional.scala 39:67 ControlLogic.scala 352:16 ControlLogic.scala 96:12]
  wire [2:0] _GEN_86 = _T_63 ? 3'h3 : _GEN_83; // @[Conditional.scala 39:67 ControlLogic.scala 343:17]
  wire  _GEN_87 = _T_63 | _T_64; // @[Conditional.scala 39:67 ControlLogic.scala 344:15]
  wire  _GEN_88 = _T_63 ? 1'h0 : _T_64; // @[Conditional.scala 39:67 ControlLogic.scala 88:12]
  wire [1:0] _GEN_89 = _T_63 ? 2'h1 : _GEN_85; // @[Conditional.scala 39:67 ControlLogic.scala 96:12]
  wire [2:0] _GEN_90 = _T_62 ? 3'h3 : _GEN_86; // @[Conditional.scala 39:67 ControlLogic.scala 339:17]
  wire  _GEN_91 = _T_62 | _GEN_87; // @[Conditional.scala 39:67 ControlLogic.scala 340:15]
  wire  _GEN_92 = _T_62 ? 1'h0 : _GEN_87; // @[Conditional.scala 39:67 ControlLogic.scala 92:11]
  wire  _GEN_93 = _T_62 ? 1'h0 : _GEN_88; // @[Conditional.scala 39:67 ControlLogic.scala 88:12]
  wire [1:0] _GEN_94 = _T_62 ? 2'h1 : _GEN_89; // @[Conditional.scala 39:67 ControlLogic.scala 96:12]
  wire [2:0] _GEN_95 = _T_49 ? _GEN_78 : _GEN_90; // @[Conditional.scala 39:67]
  wire  _GEN_96 = _T_49 ? _GEN_79 : _GEN_92; // @[Conditional.scala 39:67]
  wire  _GEN_97 = _T_49 ? _GEN_79 : _GEN_91; // @[Conditional.scala 39:67]
  wire  _GEN_98 = _T_49 ? _GEN_80 : 1'h1; // @[Conditional.scala 39:67 ControlLogic.scala 89:13]
  wire  _GEN_99 = _T_49 ? _GEN_81 : _GEN_93; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_101 = _T_49 ? 2'h1 : _GEN_94; // @[Conditional.scala 39:67 ControlLogic.scala 96:12]
  wire [2:0] _GEN_102 = _T_44 ? 3'h2 : _GEN_95; // @[Conditional.scala 39:67 ControlLogic.scala 262:17]
  wire  _GEN_103 = _T_44 | _GEN_97; // @[Conditional.scala 39:67 ControlLogic.scala 263:15]
  wire  _GEN_105 = _T_44 ? 1'h0 : _GEN_98; // @[Conditional.scala 39:67 ControlLogic.scala 265:17]
  wire [1:0] _GEN_106 = _T_44 ? _GEN_49 : 2'h2; // @[Conditional.scala 39:67 ControlLogic.scala 98:15]
  wire  _GEN_107 = _T_44 ? 1'h0 : _GEN_96; // @[Conditional.scala 39:67 ControlLogic.scala 92:11]
  wire  _GEN_108 = _T_44 ? 1'h0 : _GEN_99; // @[Conditional.scala 39:67 ControlLogic.scala 88:12]
  wire  _GEN_109 = _T_44 ? 1'h0 : _T_49 & _GEN_82; // @[Conditional.scala 39:67 ControlLogic.scala 90:11]
  wire [1:0] _GEN_110 = _T_44 ? 2'h1 : _GEN_101; // @[Conditional.scala 39:67 ControlLogic.scala 96:12]
  wire [3:0] _GEN_112 = _T_34 ? _GEN_45 : 4'h0; // @[Conditional.scala 39:67 ControlLogic.scala 101:11]
  wire [2:0] _GEN_114 = _T_34 ? 3'h0 : _GEN_102; // @[Conditional.scala 39:67 ControlLogic.scala 95:13]
  wire  _GEN_115 = _T_34 ? 1'h0 : _GEN_103; // @[Conditional.scala 39:67 ControlLogic.scala 91:11]
  wire  _GEN_116 = _T_34 ? 1'h0 : _T_44; // @[Conditional.scala 39:67 ControlLogic.scala 93:12]
  wire [1:0] _GEN_118 = _T_34 ? 2'h2 : _GEN_106; // @[Conditional.scala 39:67 ControlLogic.scala 98:15]
  wire  _GEN_119 = _T_34 ? 1'h0 : _GEN_107; // @[Conditional.scala 39:67 ControlLogic.scala 92:11]
  wire  _GEN_120 = _T_34 ? 1'h0 : _GEN_108; // @[Conditional.scala 39:67 ControlLogic.scala 88:12]
  wire  _GEN_121 = _T_34 ? 1'h0 : _GEN_109; // @[Conditional.scala 39:67 ControlLogic.scala 90:11]
  wire [1:0] _GEN_122 = _T_34 ? 2'h1 : _GEN_110; // @[Conditional.scala 39:67 ControlLogic.scala 96:12]
  wire  _GEN_123 = _T_33 | _GEN_120; // @[Conditional.scala 39:67 ControlLogic.scala 222:16]
  wire [2:0] _GEN_124 = _T_33 ? 3'h1 : _GEN_114; // @[Conditional.scala 39:67 ControlLogic.scala 223:17]
  wire  _GEN_125 = _T_33 | _GEN_115; // @[Conditional.scala 39:67 ControlLogic.scala 224:15]
  wire [1:0] _GEN_126 = _T_33 ? 2'h2 : _GEN_122; // @[Conditional.scala 39:67 ControlLogic.scala 225:16]
  wire  _GEN_127 = _T_33 ? 1'h0 : _T_34; // @[Conditional.scala 39:67 ControlLogic.scala 100:12]
  wire [3:0] _GEN_128 = _T_33 ? 4'h0 : _GEN_112; // @[Conditional.scala 39:67 ControlLogic.scala 101:11]
  wire  _GEN_129 = _T_33 ? 1'h0 : _T_34 & _GEN_46; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire  _GEN_130 = _T_33 ? 1'h0 : _GEN_116; // @[Conditional.scala 39:67 ControlLogic.scala 93:12]
  wire [1:0] _GEN_132 = _T_33 ? 2'h2 : _GEN_118; // @[Conditional.scala 39:67 ControlLogic.scala 98:15]
  wire  _GEN_133 = _T_33 ? 1'h0 : _GEN_119; // @[Conditional.scala 39:67 ControlLogic.scala 92:11]
  wire  _GEN_134 = _T_33 ? 1'h0 : _GEN_121; // @[Conditional.scala 39:67 ControlLogic.scala 90:11]
  wire  _GEN_135 = _T_32 ? 1'h0 : _GEN_123; // @[Conditional.scala 39:67 ControlLogic.scala 88:12]
  wire [2:0] _GEN_136 = _T_32 ? 3'h0 : _GEN_124; // @[Conditional.scala 39:67 ControlLogic.scala 95:13]
  wire  _GEN_137 = _T_32 ? 1'h0 : _GEN_125; // @[Conditional.scala 39:67 ControlLogic.scala 91:11]
  wire [1:0] _GEN_138 = _T_32 ? 2'h1 : _GEN_126; // @[Conditional.scala 39:67 ControlLogic.scala 96:12]
  wire  _GEN_139 = _T_32 ? 1'h0 : _GEN_127; // @[Conditional.scala 39:67 ControlLogic.scala 100:12]
  wire [3:0] _GEN_140 = _T_32 ? 4'h0 : _GEN_128; // @[Conditional.scala 39:67 ControlLogic.scala 101:11]
  wire  _GEN_141 = _T_32 ? 1'h0 : _GEN_129; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire  _GEN_142 = _T_32 ? 1'h0 : _GEN_130; // @[Conditional.scala 39:67 ControlLogic.scala 93:12]
  wire [1:0] _GEN_144 = _T_32 ? 2'h2 : _GEN_132; // @[Conditional.scala 39:67 ControlLogic.scala 98:15]
  wire  _GEN_145 = _T_32 ? 1'h0 : _GEN_133; // @[Conditional.scala 39:67 ControlLogic.scala 92:11]
  wire  _GEN_146 = _T_32 ? 1'h0 : _GEN_134; // @[Conditional.scala 39:67 ControlLogic.scala 90:11]
  wire  _GEN_147 = _T_21 | _GEN_137; // @[Conditional.scala 39:67 ControlLogic.scala 177:15]
  wire [2:0] _GEN_148 = _T_21 ? 3'h1 : _GEN_136; // @[Conditional.scala 39:67 ControlLogic.scala 178:17]
  wire [3:0] _GEN_149 = _T_21 ? _GEN_28 : 4'h0; // @[Conditional.scala 39:67 ControlLogic.scala 94:13]
  wire  _GEN_150 = _T_21 ? 1'h0 : _GEN_135; // @[Conditional.scala 39:67 ControlLogic.scala 88:12]
  wire [1:0] _GEN_151 = _T_21 ? 2'h1 : _GEN_138; // @[Conditional.scala 39:67 ControlLogic.scala 96:12]
  wire  _GEN_152 = _T_21 ? 1'h0 : _GEN_139; // @[Conditional.scala 39:67 ControlLogic.scala 100:12]
  wire [3:0] _GEN_153 = _T_21 ? 4'h0 : _GEN_140; // @[Conditional.scala 39:67 ControlLogic.scala 101:11]
  wire  _GEN_154 = _T_21 ? 1'h0 : _GEN_141; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire  _GEN_155 = _T_21 ? 1'h0 : _GEN_142; // @[Conditional.scala 39:67 ControlLogic.scala 93:12]
  wire [1:0] _GEN_157 = _T_21 ? 2'h2 : _GEN_144; // @[Conditional.scala 39:67 ControlLogic.scala 98:15]
  wire  _GEN_158 = _T_21 ? 1'h0 : _GEN_145; // @[Conditional.scala 39:67 ControlLogic.scala 92:11]
  wire  _GEN_159 = _T_21 ? 1'h0 : _GEN_146; // @[Conditional.scala 39:67 ControlLogic.scala 90:11]
  wire  _GEN_160 = _T_20 ? 1'h0 : _GEN_147; // @[Conditional.scala 39:67 ControlLogic.scala 91:11]
  wire [2:0] _GEN_161 = _T_20 ? 3'h0 : _GEN_148; // @[Conditional.scala 39:67 ControlLogic.scala 95:13]
  wire [3:0] _GEN_162 = _T_20 ? 4'h0 : _GEN_149; // @[Conditional.scala 39:67 ControlLogic.scala 94:13]
  wire  _GEN_163 = _T_20 ? 1'h0 : _GEN_150; // @[Conditional.scala 39:67 ControlLogic.scala 88:12]
  wire [1:0] _GEN_164 = _T_20 ? 2'h1 : _GEN_151; // @[Conditional.scala 39:67 ControlLogic.scala 96:12]
  wire  _GEN_165 = _T_20 ? 1'h0 : _GEN_152; // @[Conditional.scala 39:67 ControlLogic.scala 100:12]
  wire [3:0] _GEN_166 = _T_20 ? 4'h0 : _GEN_153; // @[Conditional.scala 39:67 ControlLogic.scala 101:11]
  wire  _GEN_167 = _T_20 ? 1'h0 : _GEN_154; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire  _GEN_168 = _T_20 ? 1'h0 : _GEN_155; // @[Conditional.scala 39:67 ControlLogic.scala 93:12]
  wire [1:0] _GEN_170 = _T_20 ? 2'h2 : _GEN_157; // @[Conditional.scala 39:67 ControlLogic.scala 98:15]
  wire  _GEN_171 = _T_20 ? 1'h0 : _GEN_158; // @[Conditional.scala 39:67 ControlLogic.scala 92:11]
  wire  _GEN_172 = _T_20 ? 1'h0 : _GEN_159; // @[Conditional.scala 39:67 ControlLogic.scala 90:11]
  wire [1:0] _GEN_173 = _T_13 ? 2'h0 : _GEN_164; // @[Conditional.scala 39:67 ControlLogic.scala 150:16]
  wire  _GEN_174 = _T_13 | _GEN_160; // @[Conditional.scala 39:67 ControlLogic.scala 151:15]
  wire [2:0] _GEN_175 = _T_13 ? 3'h1 : _GEN_161; // @[Conditional.scala 39:67 ControlLogic.scala 152:17]
  wire [1:0] _GEN_176 = _T_13 ? _GEN_18 : _GEN_170; // @[Conditional.scala 39:67]
  wire  _GEN_177 = _T_13 & _GEN_19; // @[Conditional.scala 39:67 ControlLogic.scala 97:12]
  wire [3:0] _GEN_178 = _T_13 ? 4'h0 : _GEN_162; // @[Conditional.scala 39:67 ControlLogic.scala 94:13]
  wire  _GEN_179 = _T_13 ? 1'h0 : _GEN_163; // @[Conditional.scala 39:67 ControlLogic.scala 88:12]
  wire  _GEN_180 = _T_13 ? 1'h0 : _GEN_165; // @[Conditional.scala 39:67 ControlLogic.scala 100:12]
  wire [3:0] _GEN_181 = _T_13 ? 4'h0 : _GEN_166; // @[Conditional.scala 39:67 ControlLogic.scala 101:11]
  wire  _GEN_182 = _T_13 ? 1'h0 : _GEN_167; // @[Conditional.scala 39:67 ControlLogic.scala 99:13]
  wire  _GEN_183 = _T_13 ? 1'h0 : _GEN_168; // @[Conditional.scala 39:67 ControlLogic.scala 93:12]
  wire  _GEN_184 = _T_13 | (_T_20 | (_T_21 | (_T_32 | (_T_33 | (_T_34 | _GEN_105))))); // @[Conditional.scala 39:67 ControlLogic.scala 89:13]
  wire  _GEN_185 = _T_13 ? 1'h0 : _GEN_171; // @[Conditional.scala 39:67 ControlLogic.scala 92:11]
  wire  _GEN_186 = _T_13 ? 1'h0 : _GEN_172; // @[Conditional.scala 39:67 ControlLogic.scala 90:11]
  assign io_pCSel = _T_1 ? 1'h0 : _GEN_179; // @[Conditional.scala 40:58 ControlLogic.scala 88:12]
  assign io_regWEn = _T_1 | _GEN_184; // @[Conditional.scala 40:58 ControlLogic.scala 89:13]
  assign io_brUn = _T_1 ? 1'h0 : _GEN_186; // @[Conditional.scala 40:58 ControlLogic.scala 90:11]
  assign io_bSel = _T_1 ? 1'h0 : _GEN_174; // @[Conditional.scala 40:58 ControlLogic.scala 91:11]
  assign io_aSel = _T_1 ? 1'h0 : _GEN_185; // @[Conditional.scala 40:58 ControlLogic.scala 92:11]
  assign io_memRW = _T_1 ? 1'h0 : _GEN_183; // @[Conditional.scala 40:58 ControlLogic.scala 93:12]
  assign io_memUn = _T_1 ? 1'h0 : _GEN_177; // @[Conditional.scala 40:58 ControlLogic.scala 97:12]
  assign io_haltPC = _T_1 ? 1'h0 : _GEN_182; // @[Conditional.scala 40:58 ControlLogic.scala 99:13]
  assign io_eCall = _T_1 ? 1'h0 : _GEN_180; // @[Conditional.scala 40:58 ControlLogic.scala 100:12]
  assign io_aLUSel = _T_1 ? _GEN_9 : _GEN_178; // @[Conditional.scala 40:58]
  assign io_call = _T_1 ? 4'h0 : _GEN_181; // @[Conditional.scala 40:58 ControlLogic.scala 101:11]
  assign io_immSel = _T_1 ? 3'h0 : _GEN_175; // @[Conditional.scala 40:58 ControlLogic.scala 95:13]
  assign io_wBSel = _T_1 ? 2'h1 : _GEN_173; // @[Conditional.scala 40:58 ControlLogic.scala 96:12]
  assign io_memWidth = _T_1 ? 2'h2 : _GEN_176; // @[Conditional.scala 40:58 ControlLogic.scala 98:15]
endmodule
module ALU(
  input  [3:0]  io_aLUSel,
  input         io_aSel,
  input         io_bSel,
  input  [31:0] io_dataA,
  input  [31:0] io_dataB,
  input  [31:0] io_pCIn,
  input  [31:0] io_immIn,
  output [31:0] io_result
);
  wire [31:0] operandA = io_aSel ? io_pCIn : io_dataA; // @[ALU.scala 31:21]
  wire [31:0] operandB = io_bSel ? io_immIn : io_dataB; // @[ALU.scala 32:21]
  wire [4:0] shamt = operandB[4:0]; // @[ALU.scala 33:23]
  wire  _T = 4'h0 == io_aLUSel; // @[Conditional.scala 37:30]
  wire [31:0] _T_1 = io_aSel ? io_pCIn : io_dataA; // @[ALU.scala 37:36]
  wire [31:0] _T_2 = io_bSel ? io_immIn : io_dataB; // @[ALU.scala 37:56]
  wire [31:0] _T_6 = $signed(_T_1) + $signed(_T_2); // @[ALU.scala 37:66]
  wire  _T_7 = 4'h1 == io_aLUSel; // @[Conditional.scala 37:30]
  wire [31:0] _T_13 = $signed(_T_1) - $signed(_T_2); // @[ALU.scala 40:66]
  wire  _T_14 = 4'h2 == io_aLUSel; // @[Conditional.scala 37:30]
  wire [31:0] _T_15 = operandA & operandB; // @[ALU.scala 43:29]
  wire  _T_16 = 4'h3 == io_aLUSel; // @[Conditional.scala 37:30]
  wire [31:0] _T_17 = operandA | operandB; // @[ALU.scala 46:29]
  wire  _T_18 = 4'h4 == io_aLUSel; // @[Conditional.scala 37:30]
  wire [31:0] _T_19 = operandA ^ operandB; // @[ALU.scala 49:29]
  wire  _T_20 = 4'h5 == io_aLUSel; // @[Conditional.scala 37:30]
  wire  _T_23 = $signed(_T_1) < $signed(_T_2); // @[ALU.scala 52:30]
  wire  _T_24 = 4'h6 == io_aLUSel; // @[Conditional.scala 37:30]
  wire [62:0] _GEN_12 = {{31'd0}, operandA}; // @[ALU.scala 59:29]
  wire [62:0] _T_25 = _GEN_12 << shamt; // @[ALU.scala 59:29]
  wire  _T_26 = 4'h7 == io_aLUSel; // @[Conditional.scala 37:30]
  wire  _T_27 = operandA < operandB; // @[ALU.scala 62:21]
  wire  _T_28 = 4'h8 == io_aLUSel; // @[Conditional.scala 37:30]
  wire [31:0] _T_29 = operandA >> shamt; // @[ALU.scala 69:29]
  wire  _T_30 = 4'h9 == io_aLUSel; // @[Conditional.scala 37:30]
  wire [31:0] _T_33 = $signed(_T_1) >>> operandB; // @[ALU.scala 72:58]
  wire [31:0] _GEN_2 = _T_30 ? _T_33 : 32'h0; // @[Conditional.scala 39:67 ALU.scala 72:17 ALU.scala 28:13]
  wire [31:0] _GEN_3 = _T_28 ? _T_29 : _GEN_2; // @[Conditional.scala 39:67 ALU.scala 69:17]
  wire [31:0] _GEN_4 = _T_26 ? {{31'd0}, _T_27} : _GEN_3; // @[Conditional.scala 39:67]
  wire [62:0] _GEN_5 = _T_24 ? _T_25 : {{31'd0}, _GEN_4}; // @[Conditional.scala 39:67 ALU.scala 59:17]
  wire [62:0] _GEN_6 = _T_20 ? {{62'd0}, _T_23} : _GEN_5; // @[Conditional.scala 39:67]
  wire [62:0] _GEN_7 = _T_18 ? {{31'd0}, _T_19} : _GEN_6; // @[Conditional.scala 39:67 ALU.scala 49:17]
  wire [62:0] _GEN_8 = _T_16 ? {{31'd0}, _T_17} : _GEN_7; // @[Conditional.scala 39:67 ALU.scala 46:17]
  wire [62:0] _GEN_9 = _T_14 ? {{31'd0}, _T_15} : _GEN_8; // @[Conditional.scala 39:67 ALU.scala 43:17]
  wire [62:0] _GEN_10 = _T_7 ? {{31'd0}, _T_13} : _GEN_9; // @[Conditional.scala 39:67 ALU.scala 40:17]
  wire [62:0] _GEN_11 = _T ? {{31'd0}, _T_6} : _GEN_10; // @[Conditional.scala 40:58 ALU.scala 37:17]
  assign io_result = _GEN_11[31:0];
endmodule
module ImmediateGenerator(
  input  [24:0] io_immIn,
  input  [2:0]  io_immSel,
  output [31:0] io_immOut
);
  wire  _T = 3'h0 == io_immSel; // @[Conditional.scala 37:30]
  wire  _T_1 = 3'h1 == io_immSel; // @[Conditional.scala 37:30]
  wire [19:0] hi = io_immIn[24] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [11:0] lo = io_immIn[24:13]; // @[ImmediateGenerator.scala 30:54]
  wire [31:0] _T_4 = {hi,lo}; // @[Cat.scala 30:58]
  wire  _T_5 = 3'h2 == io_immSel; // @[Conditional.scala 37:30]
  wire [6:0] hi_lo = io_immIn[24:18]; // @[ImmediateGenerator.scala 33:54]
  wire [4:0] lo_1 = io_immIn[4:0]; // @[ImmediateGenerator.scala 33:71]
  wire [31:0] _T_8 = {hi,hi_lo,lo_1}; // @[Cat.scala 30:58]
  wire  _T_9 = 3'h3 == io_immSel; // @[Conditional.scala 37:30]
  wire [19:0] hi_2 = io_immIn[24:5]; // @[ImmediateGenerator.scala 36:32]
  wire [31:0] _T_10 = {hi_2,12'h0}; // @[Cat.scala 30:58]
  wire  _T_11 = 3'h4 == io_immSel; // @[Conditional.scala 37:30]
  wire [11:0] hi_hi_hi = io_immIn[24] ? 12'hfff : 12'h0; // @[Bitwise.scala 72:12]
  wire [7:0] hi_lo_1 = io_immIn[12:5]; // @[ImmediateGenerator.scala 39:68]
  wire  lo_hi_hi = io_immIn[13]; // @[ImmediateGenerator.scala 39:84]
  wire [9:0] lo_hi_lo = io_immIn[23:14]; // @[ImmediateGenerator.scala 39:98]
  wire [32:0] _T_14 = {hi_hi_hi,io_immIn[24],hi_lo_1,lo_hi_hi,lo_hi_lo,1'h0}; // @[Cat.scala 30:58]
  wire  _T_15 = 3'h5 == io_immSel; // @[Conditional.scala 37:30]
  wire [18:0] hi_hi_2 = io_immIn[24] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 72:12]
  wire [3:0] lo_hi_1 = io_immIn[4:1]; // @[ImmediateGenerator.scala 42:71]
  wire [30:0] _T_18 = {hi_hi_2,hi_lo,lo_hi_1,1'h0}; // @[Cat.scala 30:58]
  wire [30:0] _GEN_0 = _T_15 ? _T_18 : 31'h0; // @[Conditional.scala 39:67 ImmediateGenerator.scala 42:17 ImmediateGenerator.scala 22:13]
  wire [32:0] _GEN_1 = _T_11 ? _T_14 : {{2'd0}, _GEN_0}; // @[Conditional.scala 39:67 ImmediateGenerator.scala 39:17]
  wire [32:0] _GEN_2 = _T_9 ? {{1'd0}, _T_10} : _GEN_1; // @[Conditional.scala 39:67 ImmediateGenerator.scala 36:17]
  wire [32:0] _GEN_3 = _T_5 ? {{1'd0}, _T_8} : _GEN_2; // @[Conditional.scala 39:67 ImmediateGenerator.scala 33:17]
  wire [32:0] _GEN_4 = _T_1 ? {{1'd0}, _T_4} : _GEN_3; // @[Conditional.scala 39:67 ImmediateGenerator.scala 30:17]
  wire [32:0] _GEN_5 = _T ? 33'h0 : _GEN_4; // @[Conditional.scala 40:58 ImmediateGenerator.scala 27:17]
  assign io_immOut = _GEN_5[31:0];
endmodule
module DataMemory(
  input         clock,
  input  [31:0] io_address,
  input  [31:0] io_dataIn,
  input         io_memRW,
  input         io_memUn,
  input  [1:0]  io_memWidth,
  output [31:0] io_dataOut
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [7:0] dataMem [0:2097151]; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_MPORT_7_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_MPORT_7_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_MPORT_8_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_MPORT_8_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_lo_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_lo_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_hi_1_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_hi_1_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_lo_1_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_lo_1_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_MPORT_9_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_MPORT_9_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_hi_3_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_hi_3_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_lo_2_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_lo_2_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_hi_hi_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_hi_hi_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_hi_lo_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_hi_lo_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_lo_hi_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_lo_hi_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_lo_lo_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_lo_lo_addr; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_MPORT_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_MPORT_addr; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_mask; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_en; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_MPORT_1_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_MPORT_1_addr; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_1_mask; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_1_en; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_MPORT_2_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_MPORT_2_addr; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_2_mask; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_2_en; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_MPORT_3_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_MPORT_3_addr; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_3_mask; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_3_en; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_MPORT_4_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_MPORT_4_addr; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_4_mask; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_4_en; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_MPORT_5_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_MPORT_5_addr; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_5_mask; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_5_en; // @[DataMemory.scala 19:20]
  wire [7:0] dataMem_MPORT_6_data; // @[DataMemory.scala 19:20]
  wire [20:0] dataMem_MPORT_6_addr; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_6_mask; // @[DataMemory.scala 19:20]
  wire  dataMem_MPORT_6_en; // @[DataMemory.scala 19:20]
  wire  _T = 2'h0 == io_memWidth; // @[Conditional.scala 37:30]
  wire  _T_3 = 2'h1 == io_memWidth; // @[Conditional.scala 37:30]
  wire [31:0] _T_7 = io_address + 32'h1; // @[DataMemory.scala 31:34]
  wire  _T_10 = 2'h2 == io_memWidth; // @[Conditional.scala 37:30]
  wire [31:0] _T_18 = io_address + 32'h2; // @[DataMemory.scala 36:34]
  wire [31:0] _T_22 = io_address + 32'h3; // @[DataMemory.scala 37:34]
  wire  _GEN_20 = _T_3 ? 1'h0 : _T_10; // @[Conditional.scala 39:67 DataMemory.scala 19:20]
  wire  _GEN_36 = _T ? 1'h0 : _T_3; // @[Conditional.scala 40:58 DataMemory.scala 19:20]
  wire  _GEN_43 = _T ? 1'h0 : _GEN_20; // @[Conditional.scala 40:58 DataMemory.scala 19:20]
  wire [23:0] hi = dataMem_MPORT_8_data[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_31 = {hi,dataMem_lo_data}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_78 = io_memUn ? {{24'd0}, dataMem_MPORT_7_data} : _T_31; // @[DataMemory.scala 45:21 DataMemory.scala 46:20 DataMemory.scala 48:20]
  wire  _GEN_81 = io_memUn ? 1'h0 : 1'h1; // @[DataMemory.scala 45:21 DataMemory.scala 19:20 DataMemory.scala 48:47]
  wire [15:0] _T_37 = {dataMem_hi_1_data,dataMem_lo_1_data}; // @[Cat.scala 30:58]
  wire [15:0] hi_2 = dataMem_MPORT_9_data[7] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_47 = {hi_2,dataMem_hi_3_data,dataMem_lo_2_data}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_85 = io_memUn ? {{16'd0}, _T_37} : _T_47; // @[DataMemory.scala 52:21 DataMemory.scala 53:20 DataMemory.scala 55:20]
  wire [31:0] _T_59 = {dataMem_hi_hi_data,dataMem_hi_lo_data,dataMem_lo_hi_data,dataMem_lo_lo_data}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_95 = _T_10 ? _T_59 : 32'h0; // @[Conditional.scala 39:67 DataMemory.scala 59:18 DataMemory.scala 21:14]
  wire  _GEN_98 = _T_3 & io_memUn; // @[Conditional.scala 39:67 DataMemory.scala 19:20]
  wire [31:0] _GEN_100 = _T_3 ? _GEN_85 : _GEN_95; // @[Conditional.scala 39:67]
  wire  _GEN_103 = _T_3 & _GEN_81; // @[Conditional.scala 39:67 DataMemory.scala 19:20]
  assign dataMem_MPORT_7_addr = io_address[20:0];
  assign dataMem_MPORT_7_data = dataMem[dataMem_MPORT_7_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_MPORT_8_addr = io_address[20:0];
  assign dataMem_MPORT_8_data = dataMem[dataMem_MPORT_8_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_lo_addr = io_address[20:0];
  assign dataMem_lo_data = dataMem[dataMem_lo_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_hi_1_addr = _T_7[20:0];
  assign dataMem_hi_1_data = dataMem[dataMem_hi_1_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_lo_1_addr = io_address[20:0];
  assign dataMem_lo_1_data = dataMem[dataMem_lo_1_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_MPORT_9_addr = _T_7[20:0];
  assign dataMem_MPORT_9_data = dataMem[dataMem_MPORT_9_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_hi_3_addr = _T_7[20:0];
  assign dataMem_hi_3_data = dataMem[dataMem_hi_3_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_lo_2_addr = io_address[20:0];
  assign dataMem_lo_2_data = dataMem[dataMem_lo_2_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_hi_hi_addr = _T_22[20:0];
  assign dataMem_hi_hi_data = dataMem[dataMem_hi_hi_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_hi_lo_addr = _T_18[20:0];
  assign dataMem_hi_lo_data = dataMem[dataMem_hi_lo_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_lo_hi_addr = _T_7[20:0];
  assign dataMem_lo_hi_data = dataMem[dataMem_lo_hi_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_lo_lo_addr = io_address[20:0];
  assign dataMem_lo_lo_data = dataMem[dataMem_lo_lo_addr]; // @[DataMemory.scala 19:20]
  assign dataMem_MPORT_data = io_dataIn[7:0];
  assign dataMem_MPORT_addr = io_address[20:0];
  assign dataMem_MPORT_mask = 1'h1;
  assign dataMem_MPORT_en = io_memRW & _T;
  assign dataMem_MPORT_1_data = io_dataIn[7:0];
  assign dataMem_MPORT_1_addr = io_address[20:0];
  assign dataMem_MPORT_1_mask = 1'h1;
  assign dataMem_MPORT_1_en = io_memRW & _GEN_36;
  assign dataMem_MPORT_2_data = io_dataIn[15:8];
  assign dataMem_MPORT_2_addr = _T_7[20:0];
  assign dataMem_MPORT_2_mask = 1'h1;
  assign dataMem_MPORT_2_en = io_memRW & _GEN_36;
  assign dataMem_MPORT_3_data = io_dataIn[7:0];
  assign dataMem_MPORT_3_addr = io_address[20:0];
  assign dataMem_MPORT_3_mask = 1'h1;
  assign dataMem_MPORT_3_en = io_memRW & _GEN_43;
  assign dataMem_MPORT_4_data = io_dataIn[15:8];
  assign dataMem_MPORT_4_addr = _T_7[20:0];
  assign dataMem_MPORT_4_mask = 1'h1;
  assign dataMem_MPORT_4_en = io_memRW & _GEN_43;
  assign dataMem_MPORT_5_data = io_dataIn[23:16];
  assign dataMem_MPORT_5_addr = _T_18[20:0];
  assign dataMem_MPORT_5_mask = 1'h1;
  assign dataMem_MPORT_5_en = io_memRW & _GEN_43;
  assign dataMem_MPORT_6_data = io_dataIn[31:24];
  assign dataMem_MPORT_6_addr = _T_22[20:0];
  assign dataMem_MPORT_6_mask = 1'h1;
  assign dataMem_MPORT_6_en = io_memRW & _GEN_43;
  assign io_dataOut = _T ? _GEN_78 : _GEN_100; // @[Conditional.scala 40:58]
  always @(posedge clock) begin
    if(dataMem_MPORT_en & dataMem_MPORT_mask) begin
      dataMem[dataMem_MPORT_addr] <= dataMem_MPORT_data; // @[DataMemory.scala 19:20]
    end
    if(dataMem_MPORT_1_en & dataMem_MPORT_1_mask) begin
      dataMem[dataMem_MPORT_1_addr] <= dataMem_MPORT_1_data; // @[DataMemory.scala 19:20]
    end
    if(dataMem_MPORT_2_en & dataMem_MPORT_2_mask) begin
      dataMem[dataMem_MPORT_2_addr] <= dataMem_MPORT_2_data; // @[DataMemory.scala 19:20]
    end
    if(dataMem_MPORT_3_en & dataMem_MPORT_3_mask) begin
      dataMem[dataMem_MPORT_3_addr] <= dataMem_MPORT_3_data; // @[DataMemory.scala 19:20]
    end
    if(dataMem_MPORT_4_en & dataMem_MPORT_4_mask) begin
      dataMem[dataMem_MPORT_4_addr] <= dataMem_MPORT_4_data; // @[DataMemory.scala 19:20]
    end
    if(dataMem_MPORT_5_en & dataMem_MPORT_5_mask) begin
      dataMem[dataMem_MPORT_5_addr] <= dataMem_MPORT_5_data; // @[DataMemory.scala 19:20]
    end
    if(dataMem_MPORT_6_en & dataMem_MPORT_6_mask) begin
      dataMem[dataMem_MPORT_6_addr] <= dataMem_MPORT_6_data; // @[DataMemory.scala 19:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2097152; initvar = initvar+1)
    dataMem[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WriteBackSelector(
  input  [31:0] io_memIn,
  input  [31:0] io_aLUIn,
  input  [31:0] io_pCplus4,
  input  [1:0]  io_wBSel,
  output [31:0] io_wBOut
);
  wire  _T = 2'h0 == io_wBSel; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == io_wBSel; // @[Conditional.scala 37:30]
  wire  _T_2 = 2'h2 == io_wBSel; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_0 = _T_2 ? io_pCplus4 : 32'h0; // @[Conditional.scala 39:67 WriteBackSelector.scala 33:16 WriteBackSelector.scala 20:12]
  wire [31:0] _GEN_1 = _T_1 ? io_aLUIn : _GEN_0; // @[Conditional.scala 39:67 WriteBackSelector.scala 29:16]
  assign io_wBOut = _T ? io_memIn : _GEN_1; // @[Conditional.scala 40:58 WriteBackSelector.scala 25:16]
endmodule
module BranchComparator(
  input  [31:0] io_dataA,
  input  [31:0] io_dataB,
  input         io_brUn,
  output        io_brEq,
  output        io_brLT
);
  assign io_brEq = io_dataA == io_dataB; // @[BranchComparator.scala 10:23]
  assign io_brLT = io_brUn ? io_dataA < io_dataB : $signed(io_dataA) < $signed(io_dataB); // @[BranchComparator.scala 12:16 BranchComparator.scala 13:13 BranchComparator.scala 15:13]
endmodule
module Processor(
  input   clock,
  input   reset,
  output  io_haltOut
);
  wire  programCounter_clock; // @[Processor.scala 12:30]
  wire  programCounter_reset; // @[Processor.scala 12:30]
  wire  programCounter_io_pCSel; // @[Processor.scala 12:30]
  wire  programCounter_io_haltPC; // @[Processor.scala 12:30]
  wire [31:0] programCounter_io_aLUIn; // @[Processor.scala 12:30]
  wire [31:0] programCounter_io_pCOut; // @[Processor.scala 12:30]
  wire [31:0] programCounter_io_pCPlus4; // @[Processor.scala 12:30]
  wire  instructionMemory_clock; // @[Processor.scala 13:33]
  wire [31:0] instructionMemory_io_address; // @[Processor.scala 13:33]
  wire [31:0] instructionMemory_io_instOut; // @[Processor.scala 13:33]
  wire [31:0] instructionDecoder_io_inst; // @[Processor.scala 14:34]
  wire [4:0] instructionDecoder_io_rd; // @[Processor.scala 14:34]
  wire [4:0] instructionDecoder_io_rs1; // @[Processor.scala 14:34]
  wire [4:0] instructionDecoder_io_rs2; // @[Processor.scala 14:34]
  wire [24:0] instructionDecoder_io_imm; // @[Processor.scala 14:34]
  wire [8:0] instructionDecoder_io_ctrl; // @[Processor.scala 14:34]
  wire  registerBank_clock; // @[Processor.scala 15:28]
  wire  registerBank_reset; // @[Processor.scala 15:28]
  wire [31:0] registerBank_io_dataA; // @[Processor.scala 15:28]
  wire [31:0] registerBank_io_dataB; // @[Processor.scala 15:28]
  wire [31:0] registerBank_io_a7; // @[Processor.scala 15:28]
  wire [4:0] registerBank_io_rd; // @[Processor.scala 15:28]
  wire [4:0] registerBank_io_rs1; // @[Processor.scala 15:28]
  wire [4:0] registerBank_io_rs2; // @[Processor.scala 15:28]
  wire [31:0] registerBank_io_dataIn; // @[Processor.scala 15:28]
  wire  registerBank_io_regWrite; // @[Processor.scala 15:28]
  wire  registerBank_io_eCall; // @[Processor.scala 15:28]
  wire [3:0] registerBank_io_call; // @[Processor.scala 15:28]
  wire [8:0] controlLogic_io_ctrl; // @[Processor.scala 16:28]
  wire [31:0] controlLogic_io_a7; // @[Processor.scala 16:28]
  wire  controlLogic_io_brEq; // @[Processor.scala 16:28]
  wire  controlLogic_io_brLT; // @[Processor.scala 16:28]
  wire  controlLogic_io_pCSel; // @[Processor.scala 16:28]
  wire  controlLogic_io_regWEn; // @[Processor.scala 16:28]
  wire  controlLogic_io_brUn; // @[Processor.scala 16:28]
  wire  controlLogic_io_bSel; // @[Processor.scala 16:28]
  wire  controlLogic_io_aSel; // @[Processor.scala 16:28]
  wire  controlLogic_io_memRW; // @[Processor.scala 16:28]
  wire  controlLogic_io_memUn; // @[Processor.scala 16:28]
  wire  controlLogic_io_haltPC; // @[Processor.scala 16:28]
  wire  controlLogic_io_eCall; // @[Processor.scala 16:28]
  wire [3:0] controlLogic_io_aLUSel; // @[Processor.scala 16:28]
  wire [3:0] controlLogic_io_call; // @[Processor.scala 16:28]
  wire [2:0] controlLogic_io_immSel; // @[Processor.scala 16:28]
  wire [1:0] controlLogic_io_wBSel; // @[Processor.scala 16:28]
  wire [1:0] controlLogic_io_memWidth; // @[Processor.scala 16:28]
  wire [3:0] arithmeticLogicUnit_io_aLUSel; // @[Processor.scala 17:35]
  wire  arithmeticLogicUnit_io_aSel; // @[Processor.scala 17:35]
  wire  arithmeticLogicUnit_io_bSel; // @[Processor.scala 17:35]
  wire [31:0] arithmeticLogicUnit_io_dataA; // @[Processor.scala 17:35]
  wire [31:0] arithmeticLogicUnit_io_dataB; // @[Processor.scala 17:35]
  wire [31:0] arithmeticLogicUnit_io_pCIn; // @[Processor.scala 17:35]
  wire [31:0] arithmeticLogicUnit_io_immIn; // @[Processor.scala 17:35]
  wire [31:0] arithmeticLogicUnit_io_result; // @[Processor.scala 17:35]
  wire [24:0] immediateGenerator_io_immIn; // @[Processor.scala 18:34]
  wire [2:0] immediateGenerator_io_immSel; // @[Processor.scala 18:34]
  wire [31:0] immediateGenerator_io_immOut; // @[Processor.scala 18:34]
  wire  dataMemory_clock; // @[Processor.scala 19:26]
  wire [31:0] dataMemory_io_address; // @[Processor.scala 19:26]
  wire [31:0] dataMemory_io_dataIn; // @[Processor.scala 19:26]
  wire  dataMemory_io_memRW; // @[Processor.scala 19:26]
  wire  dataMemory_io_memUn; // @[Processor.scala 19:26]
  wire [1:0] dataMemory_io_memWidth; // @[Processor.scala 19:26]
  wire [31:0] dataMemory_io_dataOut; // @[Processor.scala 19:26]
  wire [31:0] writeBackSelector_io_memIn; // @[Processor.scala 20:33]
  wire [31:0] writeBackSelector_io_aLUIn; // @[Processor.scala 20:33]
  wire [31:0] writeBackSelector_io_pCplus4; // @[Processor.scala 20:33]
  wire [1:0] writeBackSelector_io_wBSel; // @[Processor.scala 20:33]
  wire [31:0] writeBackSelector_io_wBOut; // @[Processor.scala 20:33]
  wire [31:0] branchComparator_io_dataA; // @[Processor.scala 21:32]
  wire [31:0] branchComparator_io_dataB; // @[Processor.scala 21:32]
  wire  branchComparator_io_brUn; // @[Processor.scala 21:32]
  wire  branchComparator_io_brEq; // @[Processor.scala 21:32]
  wire  branchComparator_io_brLT; // @[Processor.scala 21:32]
  ProgramCounter programCounter ( // @[Processor.scala 12:30]
    .clock(programCounter_clock),
    .reset(programCounter_reset),
    .io_pCSel(programCounter_io_pCSel),
    .io_haltPC(programCounter_io_haltPC),
    .io_aLUIn(programCounter_io_aLUIn),
    .io_pCOut(programCounter_io_pCOut),
    .io_pCPlus4(programCounter_io_pCPlus4)
  );
  InstructionMemory instructionMemory ( // @[Processor.scala 13:33]
    .clock(instructionMemory_clock),
    .io_address(instructionMemory_io_address),
    .io_instOut(instructionMemory_io_instOut)
  );
  InstructionDecoder instructionDecoder ( // @[Processor.scala 14:34]
    .io_inst(instructionDecoder_io_inst),
    .io_rd(instructionDecoder_io_rd),
    .io_rs1(instructionDecoder_io_rs1),
    .io_rs2(instructionDecoder_io_rs2),
    .io_imm(instructionDecoder_io_imm),
    .io_ctrl(instructionDecoder_io_ctrl)
  );
  RegisterBank registerBank ( // @[Processor.scala 15:28]
    .clock(registerBank_clock),
    .reset(registerBank_reset),
    .io_dataA(registerBank_io_dataA),
    .io_dataB(registerBank_io_dataB),
    .io_a7(registerBank_io_a7),
    .io_rd(registerBank_io_rd),
    .io_rs1(registerBank_io_rs1),
    .io_rs2(registerBank_io_rs2),
    .io_dataIn(registerBank_io_dataIn),
    .io_regWrite(registerBank_io_regWrite),
    .io_eCall(registerBank_io_eCall),
    .io_call(registerBank_io_call)
  );
  ControlLogic controlLogic ( // @[Processor.scala 16:28]
    .io_ctrl(controlLogic_io_ctrl),
    .io_a7(controlLogic_io_a7),
    .io_brEq(controlLogic_io_brEq),
    .io_brLT(controlLogic_io_brLT),
    .io_pCSel(controlLogic_io_pCSel),
    .io_regWEn(controlLogic_io_regWEn),
    .io_brUn(controlLogic_io_brUn),
    .io_bSel(controlLogic_io_bSel),
    .io_aSel(controlLogic_io_aSel),
    .io_memRW(controlLogic_io_memRW),
    .io_memUn(controlLogic_io_memUn),
    .io_haltPC(controlLogic_io_haltPC),
    .io_eCall(controlLogic_io_eCall),
    .io_aLUSel(controlLogic_io_aLUSel),
    .io_call(controlLogic_io_call),
    .io_immSel(controlLogic_io_immSel),
    .io_wBSel(controlLogic_io_wBSel),
    .io_memWidth(controlLogic_io_memWidth)
  );
  ALU arithmeticLogicUnit ( // @[Processor.scala 17:35]
    .io_aLUSel(arithmeticLogicUnit_io_aLUSel),
    .io_aSel(arithmeticLogicUnit_io_aSel),
    .io_bSel(arithmeticLogicUnit_io_bSel),
    .io_dataA(arithmeticLogicUnit_io_dataA),
    .io_dataB(arithmeticLogicUnit_io_dataB),
    .io_pCIn(arithmeticLogicUnit_io_pCIn),
    .io_immIn(arithmeticLogicUnit_io_immIn),
    .io_result(arithmeticLogicUnit_io_result)
  );
  ImmediateGenerator immediateGenerator ( // @[Processor.scala 18:34]
    .io_immIn(immediateGenerator_io_immIn),
    .io_immSel(immediateGenerator_io_immSel),
    .io_immOut(immediateGenerator_io_immOut)
  );
  DataMemory dataMemory ( // @[Processor.scala 19:26]
    .clock(dataMemory_clock),
    .io_address(dataMemory_io_address),
    .io_dataIn(dataMemory_io_dataIn),
    .io_memRW(dataMemory_io_memRW),
    .io_memUn(dataMemory_io_memUn),
    .io_memWidth(dataMemory_io_memWidth),
    .io_dataOut(dataMemory_io_dataOut)
  );
  WriteBackSelector writeBackSelector ( // @[Processor.scala 20:33]
    .io_memIn(writeBackSelector_io_memIn),
    .io_aLUIn(writeBackSelector_io_aLUIn),
    .io_pCplus4(writeBackSelector_io_pCplus4),
    .io_wBSel(writeBackSelector_io_wBSel),
    .io_wBOut(writeBackSelector_io_wBOut)
  );
  BranchComparator branchComparator ( // @[Processor.scala 21:32]
    .io_dataA(branchComparator_io_dataA),
    .io_dataB(branchComparator_io_dataB),
    .io_brUn(branchComparator_io_brUn),
    .io_brEq(branchComparator_io_brEq),
    .io_brLT(branchComparator_io_brLT)
  );
  assign io_haltOut = controlLogic_io_haltPC; // @[Processor.scala 86:14]
  assign programCounter_clock = clock;
  assign programCounter_reset = reset;
  assign programCounter_io_pCSel = controlLogic_io_pCSel; // @[Processor.scala 26:27]
  assign programCounter_io_haltPC = controlLogic_io_haltPC; // @[Processor.scala 28:28]
  assign programCounter_io_aLUIn = arithmeticLogicUnit_io_result; // @[Processor.scala 27:27]
  assign instructionMemory_clock = clock;
  assign instructionMemory_io_address = {{2'd0}, programCounter_io_pCOut[31:2]}; // @[Processor.scala 31:59]
  assign instructionDecoder_io_inst = instructionMemory_io_instOut; // @[Processor.scala 34:30]
  assign registerBank_clock = clock;
  assign registerBank_reset = reset;
  assign registerBank_io_rd = instructionDecoder_io_rd; // @[Processor.scala 37:22]
  assign registerBank_io_rs1 = instructionDecoder_io_rs1; // @[Processor.scala 38:23]
  assign registerBank_io_rs2 = instructionDecoder_io_rs2; // @[Processor.scala 39:23]
  assign registerBank_io_dataIn = writeBackSelector_io_wBOut; // @[Processor.scala 40:26]
  assign registerBank_io_regWrite = controlLogic_io_regWEn; // @[Processor.scala 41:28]
  assign registerBank_io_eCall = controlLogic_io_eCall; // @[Processor.scala 43:25]
  assign registerBank_io_call = controlLogic_io_call; // @[Processor.scala 42:24]
  assign controlLogic_io_ctrl = instructionDecoder_io_ctrl; // @[Processor.scala 46:24]
  assign controlLogic_io_a7 = registerBank_io_a7; // @[Processor.scala 49:22]
  assign controlLogic_io_brEq = branchComparator_io_brEq; // @[Processor.scala 47:24]
  assign controlLogic_io_brLT = branchComparator_io_brLT; // @[Processor.scala 48:24]
  assign arithmeticLogicUnit_io_aLUSel = controlLogic_io_aLUSel; // @[Processor.scala 56:33]
  assign arithmeticLogicUnit_io_aSel = controlLogic_io_aSel; // @[Processor.scala 54:31]
  assign arithmeticLogicUnit_io_bSel = controlLogic_io_bSel; // @[Processor.scala 55:31]
  assign arithmeticLogicUnit_io_dataA = registerBank_io_dataA; // @[Processor.scala 52:32]
  assign arithmeticLogicUnit_io_dataB = registerBank_io_dataB; // @[Processor.scala 53:32]
  assign arithmeticLogicUnit_io_pCIn = programCounter_io_pCOut; // @[Processor.scala 57:31]
  assign arithmeticLogicUnit_io_immIn = immediateGenerator_io_immOut; // @[Processor.scala 58:32]
  assign immediateGenerator_io_immIn = instructionDecoder_io_imm; // @[Processor.scala 61:31]
  assign immediateGenerator_io_immSel = controlLogic_io_immSel; // @[Processor.scala 62:32]
  assign dataMemory_clock = clock;
  assign dataMemory_io_address = arithmeticLogicUnit_io_result; // @[Processor.scala 66:25]
  assign dataMemory_io_dataIn = registerBank_io_dataB; // @[Processor.scala 65:24]
  assign dataMemory_io_memRW = controlLogic_io_memRW; // @[Processor.scala 67:23]
  assign dataMemory_io_memUn = controlLogic_io_memUn; // @[Processor.scala 68:23]
  assign dataMemory_io_memWidth = controlLogic_io_memWidth; // @[Processor.scala 69:26]
  assign writeBackSelector_io_memIn = dataMemory_io_dataOut; // @[Processor.scala 72:30]
  assign writeBackSelector_io_aLUIn = arithmeticLogicUnit_io_result; // @[Processor.scala 73:30]
  assign writeBackSelector_io_pCplus4 = programCounter_io_pCPlus4; // @[Processor.scala 74:32]
  assign writeBackSelector_io_wBSel = controlLogic_io_wBSel; // @[Processor.scala 75:30]
  assign branchComparator_io_dataA = registerBank_io_dataA; // @[Processor.scala 78:29]
  assign branchComparator_io_dataB = registerBank_io_dataB; // @[Processor.scala 79:29]
  assign branchComparator_io_brUn = controlLogic_io_brUn; // @[Processor.scala 80:28]
endmodule
