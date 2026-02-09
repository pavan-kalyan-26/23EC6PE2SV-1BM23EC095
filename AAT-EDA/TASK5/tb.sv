//------------------------------------------------------------------------------
//File       : Dual Port RAM_tb.sv
//Author     : H PAVAN KALYAN/1BM23EC095
//Created    : 2026-02-09
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: The testbench applies random read/write transactions, checks data against a reference model, and measures functional coverage to validate memory behavior.
//--------------------------------------------------------------------------
module tb;
  logic clk=0, we;
  logic [7:0] addr, wdata, rdata;

  int ref_mem[int];

  dpram dut(.*);

  always #5 clk = ~clk;
covergroup cg @(posedge clk);

  cp_addr: coverpoint addr {
    bins low  = {[0:85]};
    bins mid  = {[86:170]};
    bins high = {[171:255]};
  }

  cp_we: coverpoint we {
    bins write = {1};
    bins read  = {0};
  }

endgroup

  cg c;

  initial begin
    $dumpfile("dpram.vcd");
    $dumpvars(0, tb);
    c = new();

    repeat (5) begin
      addr  = $urandom_range(0,255);
      wdata = $urandom_range(0,255);
      we = 1;
      @(posedge clk);
      ref_mem[addr] = wdata;

      we = 0;
      @(posedge clk);

      if (rdata == ref_mem[addr])
        $display("PASS addr=%0d data=%0d", addr, rdata);
      else
        $display("FAIL addr=%0d exp=%0d got=%0d", addr, ref_mem[addr], rdata);

      c.sample();
    end

    $display("Coverage = %0.2f %%", c.get_inst_coverage());
    #10 $finish;
  end
endmodule

