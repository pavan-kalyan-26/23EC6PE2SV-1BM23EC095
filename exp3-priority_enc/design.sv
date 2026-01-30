//---------------------------------------------------------------------------
// File        : Priority_encoder.sv
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-01-30
// Module      : p_enc
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : // This module implements a 4-bit priority encoder that outputs the encoded value of the highest-priority active input along with a valid signal.
//---------------------------------------------------------------------------
module p_enc(input logic [3:0]in, output logic[1:0] out,
             output logic out_valid);
  
  always_comb begin
    out_valid=1;
    if (in[3]) out=2'b11;
    else if (in[2]) out=2'b10;
    else if (in[1]) out=2'b01;
    else if (in[0]) out=2'b00;
    else begin  out=2'b00;out_valid=0;end
    end
endmodule
