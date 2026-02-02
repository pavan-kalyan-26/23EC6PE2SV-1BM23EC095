//----------------------------------------------------------------------------
// File        : alu_tb.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-02
// Module      : alu_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for ALU.Randomizes inputs and uses a covergroup to measure input combination coverage.
//----------------------------------------------------------------------------
module alu_tb;
  logic [3:0] a, b, y;
  opcode_e op;

  alu dut(.*);

  covergroup cg_alu;
    cp_op : coverpoint op;
  endgroup

  cg_alu cg = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    repeat (50) begin
      a  = $urandom();
      b  = $urandom();
      op = opcode_e'($urandom_range(0,3));

      #5;
      cg.sample();
    end

    $display("Coverage = %0.2f %%", cg.get_inst_coverage());
  end
endmodule

    
