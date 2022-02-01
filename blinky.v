module blinky(
    input clk,
    output led
    );
    
    reg [24:0] count = 0;
    
    always @ (posedge(clk)) count <= count + 1;
     
    assign led = count[24];
endmodule