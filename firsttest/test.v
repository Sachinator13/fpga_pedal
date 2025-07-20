module test(
	input [0:0] SW,
	output [0:0] LEDR
);
	assign LEDR[0] = SW[0];
endmodule