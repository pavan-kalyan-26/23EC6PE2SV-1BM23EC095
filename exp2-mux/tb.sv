//----------------------------------------------------------------------------
// File        : mux_2_1_tb.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-01-29
// Module      : mux_2_1_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for 2 to 1 mux .Randomizes inputs and uses a covergroup to measure input combination coverage.
//----------------------------------------------------------------------------
class Transaction;
  rand bit [3:0]a,b;
  rand bit sel;
endclass
 module mux_2_1_tb;
  logic [3:0] a,b,y;
  logic sel;
  mux_2_1 dut(.*);
  
  covergroup cg_mux;
    cp_sel :coverpoint sel;
  endgroup
  cg_mux cg =new();
  Transaction tr = new();
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars;
    repeat (20) begin 
      tr.randomize ();
      a=tr.a ; b=tr.b; sel =tr.sel;
      #5 ; cg.sample();
      
      if (y!== (sel?b:a)) 
        $error("MISMATCH!");
    end
    $display ("Coverage = %0.2f %%",cg.get_inst_coverage());
  end
endmodule
