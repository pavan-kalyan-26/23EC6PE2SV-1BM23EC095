//----------------------------------------------------------------------------
// File        : D-FLIPFLOP_tb.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-02
// Module      : dff_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for D FlipFlop.Randomizes inputs and uses a covergroup to measure input combination coverage.
//----------------------------------------------------------------------------
class packet;
  rand bit d,rst;
  constraint c1 {rst dist{0:=90,1:=10};}
endclass
module dff_tb;
  logic clk,rst,d,q;
  dff dut(.*);
  initial clk=0;
  always #5 clk=~clk;
  
  covergroup cg @(posedge clk);
    cross_rst_d : cross rst,d;
  endgroup
  cg c_inst =new();
  packet pkt = new();
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    repeat (100) begin
      assert(pkt.randomize());
      rst<=pkt.rst; d<=pkt.d;
      @(posedge clk);
    end
    $display("Coverage=%0.2f %%",c_inst.get_inst_coverage());
    $finish;
  end
endmodule
                
