//----------------------------------------------------------------------------
// File        : counter_tb.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-02
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for counter.Randomizes inputs and uses a covergroup to measure input combination coverage.
//----------------------------------------------------------------------------
module tb;
  logic clk=0,rst;
  logic [3:0] count;
  counter dut(.*);
  always #5 clk=~clk;
  
  covergroup cg_count @(posedge clk);
    cp_val: coverpoint count{
      bins zero={0};
      bins max={15};
      bins roll=(15 => 0);
    }
  endgroup
  cg_count cg = new();
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    rst=1;#20
    rst=0;
    repeat(40) @(posedge clk);
    $display("Coverage = %0.2f %%", cg.get_inst_coverage());

    $finish;
  end
endmodule
    
