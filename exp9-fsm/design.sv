//---------------------------------------------------------------------------
// File        : FSM_101.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-04
// Module      : FSM
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : A Mealy finite state machine that detects the input sequence 101 and asserts the output immediately upon receiving the final bit, supporting overlapping sequences.
//--------------------------------------------------------------------------
module fsm(
  input logic clk,rst,din,
  output logic out);
  
  typedef enum {s0,s1,s2} state_t;
  state_t state,nxt;
  
  always_ff @(posedge clk)begin
    
    
    if (rst)
      state<=s0;
    else
      state<=nxt;
  end
  always_ff @(posedge clk) begin
    case(state)
    s0:if (din==1'b1)begin
      nxt<=s1;out<=0;
    end
    else begin
      nxt<= s0;out<=0;
    end
    
    s1:if (din==1'b0)begin
      nxt<=s2;out<=0;
    end
    else begin
      nxt<= s1;out<=0;
    end
    
    s2:if (din==1'b1)begin
      nxt<=s1;out<=1;
    end
    else begin
      nxt<= s0;out<=0;
    end
    endcase
    
  end
endmodule
    
    
