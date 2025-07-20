module secondtest(
	input wire[3:0] SW,
	output wire [3:0] LEDR
);

	assign LEDR = SW;

endmodule