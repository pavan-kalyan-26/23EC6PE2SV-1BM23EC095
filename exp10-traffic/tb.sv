//----------------------------------------------------------------------------
// File        :Traffic_tb.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-04
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for traffic controller.Randomizes inputs and uses a covergroup to measure input combination coverage.
//----------------------------------------------------------------------------
module tb;
  logic clk=0;
  logic rst;
  light_t color;
  traffic dut (.*);
  
  always #5 clk=~clk;
  
  covergroup cg_traffic @(posedge clk);
    cp_c : coverpoint dut.color{
      bins cycle = (RED => GREEN => YELLOW => RED);
    }
  endgroup
  cg_traffic cg =new();
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars;
    rst=1;
    #10;
    rst=0;
    repeat(10) @(posedge clk);
    
    $display("Coverrage: %0.2f %%",cg.get_inst_coverage());
    $finish;
  end
endmodule 
                    
