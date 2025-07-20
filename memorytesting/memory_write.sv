module memory_writing(
	input clk,
	input we,
	input [15:0] addr,
	input [7:0] din,
	output reg [7:0] dout
);

reg [7:0] mem [0:15];

initial begin

    $readmemh("data.mem", mem);

end


always @(posedge clk) begin
	if(we)
		mem[addr] <= din;
	dout <= mem[addr];
end

endmodule