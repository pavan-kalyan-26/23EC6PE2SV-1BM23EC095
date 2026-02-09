//----------------------------------------------------------------------------
// File        : Associative.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for associative array .Randomizes inputs and uses a covergroup to measure input combination coverage.
//----------------------------------------------------------------------------

`timescale 1ns/1ps



module tb;

  int mem[int];          
  int addr;
  int data;

  covergroup cg_mem;

    // Address coverage (bucketed)
    cp_addr: coverpoint addr {
      bins low  = {[0:9999]};
      bins mid  = {[10000:49999]};
      bins high = {[50000:100000]};
    }

    // Data coverage (simple)
    cp_data: coverpoint data {
      bins zero     = {0};
      bins non_zero = default;
    }

  endgroup

  cg_mem cg;


  initial begin
  
    $dumpfile("assoc_array.vcd");
    $dumpvars(0, tb);

    cg = new();

    repeat (200) begin
      addr = $urandom_range(0, 100000);
      data = $urandom();

      mem[addr] = data;   
      cg.sample();        
    end

  
    foreach (mem[idx])
      $display("Addr: %0d  Data: %0h", idx, mem[idx]);

    $display("Final Coverage = %0.2f %%", cg.get_inst_coverage());

    #10 $finish;
  end

endmodule
