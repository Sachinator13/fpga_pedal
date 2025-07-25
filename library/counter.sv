`timescale 1ns / 100ps 		// time unit = 1ns, resoluton = 100ps
module counter #(
  parameter WIDTH = 4
)(                        // interface signals
  input  logic             clk,      // clock 
  input  logic             rst,      // reset    
  output logic [WIDTH-1:0] count     // count output
);
  always_ff @ (posedge clk)
    if (rst) count <= {WIDTH{1'b0}};
    else     count <= count + {WIDTH-1{1'b0}};
endmodule

`
