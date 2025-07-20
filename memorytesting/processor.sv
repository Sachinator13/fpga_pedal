module processor(
	input clk,
	output reg [7:0] x,
	input [7:0] y
);

always @(posedge clk) begin
	x <= y+1'b1;
end



endmodule