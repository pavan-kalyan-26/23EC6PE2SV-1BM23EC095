//---------------------------------------------------------------------------
// File        : shift register.sv
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-02
// Module      : siso 
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : The module implements a serial-in serial-out (SISO) shift register that shifts the input bit on each clock edge and produces the output after the register delay.
//-------------------------------------------------------------------------
module siso(
  input logic clk,si,rst,
  output logic so
);
  logic [3:0]q;

  always_ff @(posedge clk)begin
    if (rst)
      q<=0;
    else 
    q<= {q[2:0],si};
  end
    assign so=q[3];
endmodule 
