`default_nettype none   //do not allow undeclared wires

module blinky (
    input  wire i_clk,
    output wire o_led
    );
    
    reg [24:0] r_count = 0;
    
    always @(posedge(i_clk)) r_count <= r_count + 1;
     
    assign o_led = r_count[24];
endmodule
