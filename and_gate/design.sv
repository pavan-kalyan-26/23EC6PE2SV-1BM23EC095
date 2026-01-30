//---------------------------------------------------------------------------
// File        : and_gate.sv
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-01-21
// Module      : and_gate
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : This module implements a 2-input AND gate that outputs logic HIGH only when both inputs a and b are HIGH.
//---------------------------------------------------------------------------
module and_gate(input logic a, b, output logic y);
  assign y=a&b;
endmodule
