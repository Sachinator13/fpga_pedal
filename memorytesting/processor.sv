module processor(
	input clk,
	output reg [7:0] x,
	input [7:0] y
);

always @(posedge clk) begin
	x <= y+1'b1;
end


endmodule



// 1 cycle process, thefore we delaye dteh write address by 1.

//n cycle process delays write address by n
