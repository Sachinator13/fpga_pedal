module processor(
	input clk,
	output reg [15:0] output_sig,
	input [15:0] input_sig
);

always @(posedge clk) begin
	output_sig <= input_sig;
end


endmodule



// 1 cycle process, thefore we delaye dteh write address by 1.

//n cycle process delays write address by n
