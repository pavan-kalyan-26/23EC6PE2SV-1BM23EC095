//----------------------------------------------------------------------------
// File        : Generator-Driver.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : This example demonstrates inter-process communication using a mailbox, where functional coverage confirms that packets generated are correctly received by the driver.
//----------------------------------------------------------------------------
`timescale 1ns/1ps



class Packet;
  rand bit [7:0] val;
endclass


module tb;

  mailbox #(Packet) mbx = new();

  bit [7:0] val_mirror;   // for coverage + waveform

  covergroup cg_mbx;

    cp_val: coverpoint val_mirror {
      bins low  = {[0:85]};
      bins mid  = {[86:170]};
      bins high = {[171:255]};
    }

  endgroup

  cg_mbx cg;

  task generator();
    Packet p;
    repeat (5) begin
      p = new();
      p.randomize();
      mbx.put(p);
      $display("Generator sent   : %0d", p.val);
      #5;
    end
  endtask

 
  task driver();
    Packet p;
    repeat (5) begin
      mbx.get(p);
      val_mirror = p.val;   // mirror for coverage
      cg.sample();
      $display("Driver received : %0d", p.val);
      #5;
    end
  endtask


  initial begin
   
    $dumpfile("mailbox.vcd");
    $dumpvars(0, tb);

    cg = new();

    fork
      generator();
      driver();
    join

    $display("Final Coverage = %0.2f %%", cg.get_inst_coverage());
    #10 $finish;
  end

endmodule

