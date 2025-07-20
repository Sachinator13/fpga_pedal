`timescale 1ns/1ns

module testbench;
	reg x;
	wire y;
	test bt(
		.SW(x),
		.LEDR(y)
	);
	
	initial begin 
		x=0;
		repeat(8)
			#10 x = !x;
	end
endmodule
			