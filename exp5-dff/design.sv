//---------------------------------------------------------------------------
// File        : D FLIPFLOP.sv
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-02
// Module      : dff
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : D flip-flop captures the input value d at the rising edge of the clock and holds it at the output q until the next clock edge or a reset occurs.
//-------------------------------------------------------------------------
module dff(
  input logic clk,rst,d,
  output reg q
);
  always_ff @(posedge clk or posedge rst)begin
    if (rst)begin
      q<=0;end
    else begin
      q<=d;
    end
    
  end
endmodule 
