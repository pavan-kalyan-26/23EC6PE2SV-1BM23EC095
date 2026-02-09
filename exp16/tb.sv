//----------------------------------------------------------------------------
// File        :  SVA Temporal Sequences.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : This example uses temporal assertions and functional coverage to verify that a grant is issued a fixed number of cycles after a request.
//----------------------------------------------------------------------------

`timescale 1ns/1ps

module tb;

  bit clk = 0;
  bit req = 0;
  bit gnt = 0;

  always #5 clk = ~clk;

  property p_handshake;
    @(posedge clk) req |=> ##2 gnt;
  endproperty

  assert property (p_handshake);

  cover property (@(posedge clk) req);
  cover property (@(posedge clk) req ##2 gnt);

  covergroup cg @(posedge clk);
    cp_req: coverpoint req { bins low = {0}; bins high = {1}; }
    cp_gnt: coverpoint gnt { bins low = {0}; bins high = {1}; }
  endgroup

  cg c;

 initial begin
  $dumpfile("sva_temporal.vcd");
  $dumpvars(0, tb);

  c = new();

  @(posedge clk) req <= 1;
  @(posedge clk) req <= 0;
  @(posedge clk);
  @(posedge clk) gnt <= 1;

  @(posedge clk) gnt <= 0;   // <-- ADD THIS LINE

  #10;
  $display("Coverage = %0.2f %%", c.get_inst_coverage());

  #30 $finish;
end
    endmodule
