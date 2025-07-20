module tb_ram_1;

reg clk = 0;
reg we_write;
reg we_read;
reg [3:0] addr_w;
reg [3:0] addr_r;
reg [7:0] din_w;
reg [7:0] din_r;
wire [7:0] dout_w;
wire [7:0] dout_r;
reg [3:0] counter;
wire [7:0] proc_output;
reg [7:0] prev_dout;

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
    .addr(addr_w),
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
	addr_w <= addr_w + 1'b1;

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





















// always @(posedge clk) begin

// 	addr_w <= addr_w + 1'b1;	
// 	prev_dout <= dout_w;
// 	din_w <= prev_dout + 1'b1;


// end


// initial begin
// 	prev_dout = 8'h00;
// 	we_write = 1;
// 	addr_w = 0;
// 	din_w = 0;
	
// 	#10ns
// 	//writing to addresses 1 and 3
// 	//we_write = 1;
	
// //    addr_w = 0; din_w = 8'hAA; #10;  // Write 0xAA
// //    addr_w = 1; din_w = 8'hBB; #10;  // Write 0xBB
// //    addr_w = 2; din_w = 8'hCC; #10;  // Write 0xCC
// //    addr_w = 3; din_w = 8'hDD; #10;  // Write 0xDD
	
// //    we_write = 0;
// //    addr_w = 0; #10;   // Read addr 0
// //    addr_w = 1; #10;   // Read addr 1
// //    addr_w = 2; #10;   // Read addr 2
// //    addr_w = 3; #10;   // Read addr 3
	
// 	$writememh("output.mem", DUT.mem);
// 	$finish;
	
// end

endmodule