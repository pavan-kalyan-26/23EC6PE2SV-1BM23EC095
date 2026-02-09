//------------------------------------------------------------------------------
//File       : atm.sv
//Author     : H PAVAN KALYAN/1BM23EC095
//Created    : 2026-02-09
//Module     : atm
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: This ATM controller FSM dispenses cash only when the PIN and balance are valid, verified using assertions and functional coverage.
//--------------------------------------------------------------------------
`timescale 1ns/1ps

module atm1(
  input  logic clk, rst,
  input  logic card_inserted, pin_correct, balance_ok,
  output logic dispense_cash
);

  typedef enum logic [1:0] {IDLE, CHECK_PIN, CHECK_BAL, DISPENSE} state_t;
  state_t state, next;

  always_ff @(posedge clk or posedge rst) begin
    if (rst) state <= IDLE;
    else     state <= next;
  end

  always_comb begin
    dispense_cash = 0;
    next = state;
    case (state)
      IDLE:       if (card_inserted) next = CHECK_PIN;
      CHECK_PIN:  if (pin_correct)   next = CHECK_BAL;
      CHECK_BAL:  if (balance_ok)    next = DISPENSE;
      DISPENSE: begin
        dispense_cash = 1;
        next = IDLE;
      end
    endcase
  end

endmodule


