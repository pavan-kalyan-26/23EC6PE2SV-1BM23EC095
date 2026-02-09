//----------------------------------------------------------------------------
// File        : OOP Polymorphism.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : This example demonstrates polymorphism in SystemVerilog, where a base class handle dynamically calls the overridden method of a derived class, verified using functional coverage
//----------------------------------------------------------------------------
`timescale 1ns/1ps

class Packet;
  rand bit [7:0] data;

  virtual function void print();
    $display("Normal Packet : data = %0h", data);
  endfunction
endclass

class BadPacket extends Packet;
  virtual function void print();
    $display("ERROR Packet  : data = %0h", data);
  endfunction
endclass

module tb;

  Packet    p;
  Packet    p2;
  BadPacket bad;

  bit [7:0] data_mirror;
  bit       is_bad_pkt;

  // ==============================
  // COVERAGE
  // ==============================
  covergroup cg_pkt;
    cp_type: coverpoint is_bad_pkt {
      bins normal = {0};
      bins bad    = {1};
    }

    cp_data: coverpoint data_mirror {
      bins low  = {[0:85]};
      bins mid  = {[86:170]};
      bins high = {[171:255]};
    }
  endgroup

  cg_pkt cg;

  initial begin
    $dumpfile("polymorphism.vcd");
    $dumpvars(0, tb);

    cg = new();

    // ---------- NORMAL PACKET ----------
    p = new();
    p.data = 10;        // low
    is_bad_pkt  = 0;
    data_mirror = p.data;
    p.print();
    cg.sample();

    p.data = 120;       // mid
    data_mirror = p.data;
    cg.sample();

    // ---------- BAD PACKET ----------
    bad = new();
    p2  = bad;          // polymorphism
    p2.data = 200;      // high
    is_bad_pkt  = 1;
    data_mirror = p2.data;
    p2.print();
    cg.sample();

    $display("Final Coverage = %0.2f %%", cg.get_inst_coverage());
    #10 $finish;
  end

endmodule
