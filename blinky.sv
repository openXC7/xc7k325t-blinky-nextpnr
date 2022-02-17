module blinky(
    input clk,
    input uart_tx_in,
    output reg uart_rx_out,
    output led
    );
    
    reg [24:0] count = 0;
    reg [7:0] baud = 0;
    reg [7:0] bitcnt = 0;
    reg [8:0] char0 = 0;
    reg [351:0] msg = "Man soll sen Tag nicht vor dem Abend loben.\n";

    always @ (posedge(clk)) count <= count + 1;

    always @ (posedge(clk))
	begin
	if (baud == 86)
		begin
		baud <= 0;
		case (bitcnt)
			0: begin uart_rx_out <= 0; if (char0 < 8) begin char0 <= 344; msg[279:272] ^= "d"^"s"; end else char0 <= char0 - 8; end
			1,2,3,4,5,6,7,8: uart_rx_out <= msg[char0 + ({6'b0,bitcnt[2:0]} - 9'd1)];
			default: uart_rx_out <= 1;
			endcase
		bitcnt <= bitcnt + 1;
		end
	else
		baud <= baud + 1;
	end
     
    assign led = count[24];

endmodule

