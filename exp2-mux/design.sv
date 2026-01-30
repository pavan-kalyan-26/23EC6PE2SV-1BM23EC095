//---------------------------------------------------------------------------
// File        : mux_2_1.sv
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-01-29
// Module      : MUX_2_1
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : 4-bit 2:1 multiplexer controlled by select signal 'sel'
//---------------------------------------------------------------------------
module mux_2_1 (
  input logic [3:0]a,b,
  input logic sel,
  output logic [3:0]y
);
  
  assign y =sel?b:a;
  
endmodule
