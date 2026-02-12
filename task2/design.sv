//------------------------------------------------------------------------------
//File       : digital_clock.sv
//Author     : H PAVAN KALYAN/1BM23EC095
//Created    : 2026-02-09
//Module     : digital_clock
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: This digital clock design counts seconds and minutes synchronously using clocked logic and reset control.
//------------------------------------------------------------------------------
module digital_clock (
input logic clk,
input logic rst,
output logic [5:0] sec,
output logic [5:0] min
);
always_ff @(posedge clk or posedge rst) begin
if (rst) begin
sec <= 0;
min <= 0;
end
else begin
if (sec == 59) begin
sec <= 0;
if (min == 59)
min <= 0;
else
min <= min + 1;
end
else begin
sec <= sec + 1;
min <= min; // HOLD minute value
end
end
end
endmodule
