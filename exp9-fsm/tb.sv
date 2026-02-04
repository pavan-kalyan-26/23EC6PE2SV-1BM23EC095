//----------------------------------------------------------------------------
// File        :fsm_101_tb.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-04
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for FSM 101 SEQUENCE DETECTOR.Randomizes inputs and uses a covergroup to measure input combination coverage.
//----------------------------------------------------------------------------
module tb;
  logic clk=0;
  logic rst,din;
  logic out;
  
 
  
  always #5 clk=~clk;
  fsm dut(.*);
  
  covergroup cg_fsm @(posedge clk);
    cp_state : coverpoint dut.state;
  endgroup
  
  cg_fsm cg= new();
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars;
    rst=1;
    din=0;
    #10;
    rst=0;
    repeat (20) begin@(posedge clk);
      din=$urandom_range(0,1);
    end
    $display("Coverage:%0.2f %%",cg.get_inst_coverage());
    $finish;
    
  end
endmodule
      
      
  
  
