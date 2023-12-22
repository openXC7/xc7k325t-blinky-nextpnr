`default_nettype none   //do not allow undeclared wires

module toggly(
    input wire    clk,
    output [53:0] io_1,
    output [53:0] io_2,
    output wire led_1,
    output wire led_2
    );

   reg [24:0]     r_count = 0;
   reg [53:0]     r_io_1;
   reg [53:0]     r_io_2;

   always @(posedge(clk)) r_count <= r_count + 1;

   always @(posedge clk)
	 if (r_count[24])
       begin
	      r_io_1 <= 54'b1111111111_1111111111_1111111111_1111111111_1111111111_1111;
	      r_io_2 <= 54'b0000000000_0000000000_0000000000_0000000000_0000000000_0000;
       end
	 else
       begin
	      r_io_1 <= 54'b0000000000_0000000000_0000000000_0000000000_0000000000_0000;
	      r_io_2 <= 54'b1111111111_1111111111_1111111111_1111111111_1111111111_1111;
       end

   assign io_1 = r_io_1;
   assign io_2 = r_io_2;
   assign led_1 = r_io_1[0];
   assign led_2 = r_io_2[0];
endmodule
