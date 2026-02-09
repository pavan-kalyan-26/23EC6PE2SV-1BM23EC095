//------------------------------------------------------------------------------
//File       : Dual Port RAM.sv
//Author     : H PAVAN KALYAN/1BM23EC095
//Created    : 2026-02-09
//Module     : dpram
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: This dual-port RAM verification uses functional coverage to ensure read and write operations occur across different address ranges.
//--------------------------------------------------------------------------

`timescale 1ns/1ps

module dpram(
  input  logic clk,
  input  logic we,
  input  logic [7:0] addr,
  input  logic [7:0] wdata,
  output logic [7:0] rdata
);
  logic [7:0] mem[256];

  always_ff @(posedge clk) begin
    if (we) mem[addr] <= wdata;
    rdata <= mem[addr];
  end
endmodule

