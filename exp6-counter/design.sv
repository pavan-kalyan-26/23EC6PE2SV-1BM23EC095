
//---------------------------------------------------------------------------
// File        : counter.sv
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-02
// Module      : counter 
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : A counter increments its value on each clock edge and rolls over to zero after reaching its maximum count.
//-------------------------------------------------------------------------
module counter(
  input logic clk,rst,
  output logic [3:0]count
);
always_ff @(posedge clk or posedge rst)
  begin
    if (rst)
      count<=4'b0000;
    else 
      count<=count+1;
  end
endmodule 
