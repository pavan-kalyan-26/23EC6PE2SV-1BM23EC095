//----------------------------------------------------------------------------
// File        : The 8-byte Packet.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : This example demonstrates constrained randomization of an Ethernet packet where payload size dynamically matches the packet length.
//----------------------------------------------------------------------------
`timescale 1ns/1ps

class EthPacket;
  rand byte payload[];
  rand int len;

  constraint c_len  { len inside {[4:8]}; }
  constraint c_size { payload.size() == len; }

  function void print();
    $display("Len=%0d Payload=%p", len, payload);
  endfunction
endclass


module tb;
  EthPacket p;
  int len_mirror;

  covergroup cg;
    cp_len: coverpoint len_mirror {
      bins b[] = {[4:8]};
    }
  endgroup
  cg c;

  initial begin
    $dumpfile("packet.vcd");
    $dumpvars(0, tb);

    c = new();
    p = new();

    repeat (20) begin
      p.randomize();
      len_mirror = p.len;
      p.print();
      c.sample();
    end

    $display("Coverage = %0.2f %%", c.get_inst_coverage());
    #10 $finish;
  end
endmodule
