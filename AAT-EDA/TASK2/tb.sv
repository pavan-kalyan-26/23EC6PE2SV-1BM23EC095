//------------------------------------------------------------------------------
//File       : digital_clock_tb.sv
//Author     : H PAVAN KALYAN/1BM23EC095
//Created    : 2026-02-09
//Module     : tb_digital_clock
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: simple testbench for the digital clock.
//------------------------------------------------------------------------------
module tb_digital_clock;
logic clk = 0;
logic rst=0;
logic [5:0] sec;
logic [5:0] min;
// DUT
digital_clock dut (
.clk(clk),
.rst(rst),
.sec(sec),
.min(min)
);
// Clock generation
always #5 clk = ~clk;
// Coverage: verify 59 => 0 transition
covergroup sec_cg @(posedge clk);
coverpoint sec {
bins rollover = (59 => 0);
}
endgroup
sec_cg cg = new();
// Test sequence
initial begin
$dumpfile("dump.vcd");
$dumpvars;
rst = 1;
#10 rst = 0;
// Run long enough to see rollover
repeat (130) begin
@(posedge clk);
cg.sample();
end
$display("DIGITAL CLOCK TEST COMPLETED");
  $display("Coverage:%0.2f %%",cg.get_inst_coverage());
  
$finish;
end
endmodule
