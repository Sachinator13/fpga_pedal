module tb_ram_1;

reg clk = 0;
reg we_write;
reg we_read;
reg [3:0] addr_w;
reg [3:0] addr_r;
reg [7:0] din_w;
reg [7:0] din_r;
wire [7:0] dout_W;
wire [7:0] dout_r;
reg [3:0] counter;


//insantiate ram

counter count1 (
	.clk(clk),
	.rst(1'b0),
	.count(counter)
);

memory_writing READ (
	.clk(clk),
	.addr(addr_r),
	.we(we_read),
	.din(din_r),
	.dout(dout_w)
);

memory_writing DUT (
    .clk(clk),
    .we(we_write),
    .addr(addr_w),
    .din(din_w),
    .dout(dout_written)
);

always #5 clk = ~clk;

//test sequence


initial begin

	we_write = 0;
	addr_w = 0;
	din_w = 0;
	
	#10ns
	//writing to addresses 1 and 3
	we_write = 1;
	
   addr_w = 0; din_w = 8'hAA; #10;  // Write 0xAA
   addr_w = 1; din_w = 8'hBB; #10;  // Write 0xBB
   addr_w = 2; din_w = 8'hCC; #10;  // Write 0xCC
   addr_w = 3; din_w = 8'hDD; #10;  // Write 0xDD
	
	we_write = 0;
   addr_w = 0; #10;   // Read addr 0
   addr_w = 1; #10;   // Read addr 1
   addr_w = 2; #10;   // Read addr 2
   addr_w = 3; #10;   // Read addr 3
	
	$writememh("output.mem", DUT.mem);
	$finish;
	
end

endmodule
	