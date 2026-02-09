//------------------------------------------------------------------------------
//File       : vending machine.sv
//Author     : H PAVAN KALYAN/1BM23EC095
//Created    : 2026-02-09
//Module     : vending
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: This example models a vending machine as a finite state machine where functional coverage tracks state transitions based on randomized coin inputs.
//------------------------------------------------------------------------------

`timescale 1ns/1ps
module vending (
    input  logic        clk,
    input  logic        rst,
    input  logic [4:0]  coin,      // 5 or 10
    output logic        dispense
);

  typedef enum logic [1:0] {IDLE, HAS_5, HAS_10} state_t;
  state_t state, next_state;


  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      state <= IDLE;
    else
      state <= next_state;
  end

 
  always_comb begin
    dispense   = 0;
    next_state = state;

    case (state)
      IDLE: begin
        if (coin == 5)      next_state = HAS_5;
        else if (coin == 10) next_state = HAS_10;
      end

      HAS_5: begin
        if (coin == 5)       next_state = HAS_10;
        else if (coin == 10) begin
          dispense   = 1;
          next_state = IDLE;
        end
      end

      HAS_10: begin
        if (coin == 5 || coin == 10) begin
          dispense   = 1;
          next_state = IDLE;
        end
      end
    endcase
  end

endmodule
