//---------------------------------------------------------------------------
// File        :Traffic Controller.sv  
// Author      : H PAVAN KALYAN/1BM23EC095
// Created     : 2026-02-04
// Module      : traffic
// Project     : SystemVerilog and Verification (23EC6PE2SV),
// Faculty     : Prof. Ajaykumar Devarapalli
// Description : A Moore finite state machine that cyclically transitions through RED, GREEN, and YELLOW states on each clock cycle.
//----------------------------------------------------------------------------
typedef enum {RED,YELLOW,GREEN} light_t;
module traffic(
  input clk,rst,
  output light_t color
);
always_ff @(posedge clk)begin
  if(rst)
    color<=RED;
  else 
    case(color)
      RED: color<=GREEN;
      YELLOW: color<=RED;
      GREEN: color<=YELLOW;
    endcase
end
endmodule

  
