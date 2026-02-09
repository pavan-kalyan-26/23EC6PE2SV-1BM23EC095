//------------------------------------------------------------------------------
//File       : atm_tb.sv
//Author     : H PAVAN KALYAN/1BM23EC095
//Created    : 2026-02-09
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: simple testbench for the atm controller. randomizes the input and verify the outputs.
//--------------------------------------------------------------------------
module tb;

  logic clk = 0, rst;
  logic card_inserted, pin_correct, balance_ok;
  logic dispense_cash;

  atm1 dut(.*);

  always #5 clk = ~clk;

  covergroup cg @(posedge clk);
    coverpoint dut.state;
    coverpoint dispense_cash;
  endgroup
  cg c;

  initial begin
    $dumpfile("atm.vcd");
    $dumpvars;

    c = new();

    rst = 1;
    card_inserted = 0;
    pin_correct   = 0;
    balance_ok    = 0;

    #10 rst = 0;

    @(posedge clk) card_inserted = 1;   // IDLE → CHECK_PIN
    @(posedge clk) pin_correct   = 1;   // CHECK_PIN → CHECK_BAL
    @(posedge clk) balance_ok    = 1;   // CHECK_BAL → DISPENSE
    @(posedge clk);                     // DISPENSE (dispense_cash = 1)
    @(posedge clk);                     // return to IDLE (dispense_cash = 0)

    $display("Coverage = %0.2f %%", c.get_inst_coverage());
    $finish;
  end

endmodule
