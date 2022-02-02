module blinky (
  input clkin,
  input clkinb,
  input [7:6] sw,
  output reg [7:0] led
);

  wire clk = sw[7];
  
  always @(posedge clk)
     led = sw[6] ? 8'b0 : led+ 8'b1;
  
endmodule
