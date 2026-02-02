//---------------------------------------------------------------------------
// File        : ALU.sv
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-02
// Module      : alu
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : // This module implements a 4-bit priority encoder that outputs the encoded value of the highest-priority active input along with a valid signal.
//-------------------------------------------------------------------------
typedef enum bit [1:0] {ADD,SUB,AND,OR} opcode_e;
module alu(
  input logic [3:0] a,b,
  input opcode_e op,
  output logic [3:0]y);
 always_comb begin
   case(op)
    ADD:y=a+b;
    SUB:y=a-b;
    AND:y=a&b;
    OR:y=a|b;
  endcase
 end
endmodule
