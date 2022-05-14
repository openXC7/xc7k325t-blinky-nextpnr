module blinky(
    input clk,
    output [7:0] user_led
    );

    reg [31:0] count = 0;

    always @ (posedge(clk)) count <= count + 1;

    assign user_led[7:0] = count[31:24];
endmodule