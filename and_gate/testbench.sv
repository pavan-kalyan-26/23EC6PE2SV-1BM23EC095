//----------------------------------------------------------------------------
// File        : and_gate_tb.sv
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-01-21
// Module      : and_gate_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for and gate .Randomizes inputs and uses a covergroup to measure input combination coverage.
//--------------------------------------------------------------------------
module and_gate_tb;
  logic a, b, y;
  and_gate dut(.*);
  covergroup cg_and;
    cp_a: coverpoint a;
    cp_b: coverpoint b;
    cross_ab: cross cp_a, cp_b;
  endgroup
  
  cg_and cg =new();
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    repeat (20) begin
      a=$urandom_range(0,1);
      b=$urandom_range(0,1);
      #5;
      cg.sample();
    end
    $display("Final Coverage = %0.2f %%",cg. get_inst_coverage());
  end
endmodule
