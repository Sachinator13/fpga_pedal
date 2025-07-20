module tb_ram_1;

reg clk = 0;
reg we_write;
reg we_read;
reg [15:0] addr_w;
reg [15:0] addr_r;
reg [15:0] next_addr_r;
reg [15:0] next_addr_w;
reg [7:0] din_w;
reg [7:0] din_r;
wire [7:0] dout_w;
wire [7:0] dout_r;
reg [15:0] counter;
wire [7:0] proc_output;
reg [7:0] prev_dout;

reg [15:0] addr_pipe [0:1];     // Pipe depth = 2
reg      we_pipe   [0:1];

//insantiate ram

counter count1 (
	.clk(clk),
	.count(counter)
);

memory_writing READ (
	.clk(clk),
	.addr(addr_r),
	.we(we_read),
	.din(din_r),
	.dout(dout_r)
);

memory_writing DUT (
    .clk(clk),
    .we(we_write),
    .addr(next_addr_w),
    .din(proc_output),
    .dout(dout_w)
);

processor thingy (
	.clk(clk),
	.y(dout_r),
	.x(proc_output)

);




always #5 clk = ~clk;

//test sequence


always @(posedge clk) begin 
	addr_r <= addr_r + 1'b1;
	addr_w <= addr_r;
	next_addr_w <= addr_w;
	

end

initial begin

	we_read =1'b0;
	we_write = 1'b1;
	addr_r =1'b0;
	addr_w = 1'b0;

	#300

	$writememh("output.mem", DUT.mem);
	$finish;


end





















endmodule