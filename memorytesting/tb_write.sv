module tb_ram_1;

reg clk = 0;
reg we_write;
reg we_read;
reg [15:0] addr_w;
reg [15:0] addr_r;
reg [15:0] next_addr_r;
reg [15:0] next_addr_w;
reg [15:0] next_addr_w_2;
reg [15:0] din_w;
reg [15:0] din_r;
wire [15:0] dout_w;
wire [15:0] dout_r;
reg [15:0] counter;
wire [15:0] proc_output1;
wire [15:0] proc_output2;
reg [15:0] prev_dout;


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
    .addr(next_addr_w_2),
    .din(proc_output2),
    .dout(dout_w)
);

processor mod1 (
	.clk(clk),
	.input_sig(dout_r),
	.output_sig(proc_output1)
);

processor mod2(
	.clk(clk),
	.input_sig(proc_output1),
	.output_sig(proc_output2)
);


always #5 clk = ~clk;

//test sequence


always @(posedge clk) begin 
	addr_r <= addr_r + 1'b1;
	addr_w <= addr_r;
	next_addr_w <= addr_w;
	next_addr_w_2 <= next_addr_w;
	//depending on the delay of the processor, adjust the numbe ro fdelayed cycles here	

end

initial begin

	we_read =1'b0;
	we_write = 1'b1;
	addr_r =1'b0;
	addr_w = 1'b0;

	#3000

	$writememh("output.mem", DUT.mem);
	$finish;


end




endmodule