//----------------------------------------------------------------------------
// File        : shift register_tb.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-02
// Module      : siso_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for shift register.Randomizes inputs and uses a covergroup to measure input combination coverage.
//----------------------------------------------------------------------------
module siso_tb;
  logic clk=1;
  logic si,rst;
  logic so;
  siso dut(.*);
  always #5 clk=~clk;
  logic [3:0] q=0;
  
  covergroup cg_s @(posedge clk);
    cg_si: coverpoint si;
  endgroup
  
  cg_s cg= new();
  
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars;
    rst=1;#10;
    rst=0;
    si=0;
    repeat(50) begin
      si=$urandom();
       q<= {q[2:0],si};
      @(posedge clk);#1;
    end
    $display("Coverage:%0.2f %%",cg.get_inst_coverage());
    $finish;
  end
endmodule
