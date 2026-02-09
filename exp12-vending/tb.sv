//----------------------------------------------------------------------------
// File        : vebding_machine_tb.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : Simple testbench for vebding machine .Randomizes inputs and uses a covergroup to measure input combination coverage.
//----------------------------------------------------------------------------
`timescale 1ns/1ps

module tb;

  logic clk = 0;
  logic rst;
  logic [4:0] coin;
  logic dispense;

  // DUT
  vending dut (
    .clk(clk),
    .rst(rst),
    .coin(coin),
    .dispense(dispense)
  );

  // Clock
  always #5 clk = ~clk;

  // ==============================
  // FUNCTIONAL COVERAGE
  // ==============================
  covergroup cg_vend @(posedge clk);

    // 1. STATE COVERAGE
    cp_state: coverpoint dut.state {
      bins idle   = {0};
      bins has5   = {1};
      bins has10  = {2};
    }

    // 2. COIN COVERAGE
    cp_coin: coverpoint coin {
      bins coin5  = {5};
      bins coin10 = {10};
    }

    // 3. DISPENSE COVERAGE
    cp_disp: coverpoint dispense {
      bins dispensed = {1};
    }

    // 4. CROSS COVERAGE (VERY IMPORTANT)
    cross cp_state, cp_coin;

  endgroup

  cg_vend cg;

  // ==============================
  // STIMULUS
  // ==============================
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    cg = new();

    rst  = 1;
    coin = 0;
    #12 rst = 0;

    repeat (50) begin
      // Randomly insert 5 or 10
      coin = ($urandom_range(0,1)) ? 5 : 10;
      @(posedge clk);
    end

    $display("Final Coverage = %0.2f %%", cg.get_inst_coverage());
    $finish;
  end

endmodule
