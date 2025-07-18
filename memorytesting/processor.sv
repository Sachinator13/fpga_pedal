module processor(
	input clk,
	input [7:0] x,
	input [7:0] y
);

always @(posedge clk) begin
	x <= y;
end`