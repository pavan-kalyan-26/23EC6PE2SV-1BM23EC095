//----------------------------------------------------------------------------
// File        : priority_encoder_tb.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-01-30
// Module      : p_enc_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for priority encoder .Randomizes inputs and uses a covergroup to measure input combination coverage.
//----------------------------------------------------------------------------

 module p_enc_tb;
   logic [3:0] in;
   logic [1:0] out;
   logic out_valid;
  p_enc dut(.*);
  
  covergroup cg_p_enc;
    cp_in :coverpoint in{
    bins b0={1};//0001
    bins b1={2};//0010
    bins b2={4};//0100
    bins b3={8};//1000
    bins others =default;
    }
  endgroup
  cg_p_enc cg =new();
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars;
    repeat (50) begin 
      in=$urandom_range(0, 15);
      #5 ; cg.sample();
     end
    $display ("Coverage = %0.2f %%",cg.get_inst_coverage());
  end
endmodule
