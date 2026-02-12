//------------------------------------------------------------------------------
//File       : alu_tb.sv
//Author     : H PAVAN KALYAN/1BM23EC095
//Created    : 2026-02-09
//Module     : tb
//Project    : SystemVerilog and Verification (23EC6PE2SV),
//Faculty    : Prof. Ajaykumar Devarapalli
//Description: testbench for the alu
//--------------------------------------------------------------------------


import alu_pkg::*;
module tb;
logic[3:0] a,b,y;
opcode_e op;
alu dut (.a(a),.b(b),.op(op),.y(y));
class alu_trans;
rand logic [3:0] a, b;
rand logic [1:0] op;
// MUL must occur at least 20%
constraint op_dist {
op dist {MUL := 20, ADD := 30, SUB := 25, XOR := 25};
}
endclass
alu_trans tr;
covergroup cg_alu;
cp_op : coverpoint op;
endgroup
cg_alu cg = new();
initial begin
$dumpfile("dump11.vcd");
$dumpvars;
repeat(50) begin
tr = new();
assert(tr.randomize());
a = tr.a;
b = tr.b;
op = opcode_e'(tr.op);
#5;cg.sample();
end
$display("Coverage:%0.2f %%",cg.get_inst_coverage());
$finish;
end
endmodule
