module blinky(
    inout clkio,
    output led
    );
    
    wire clko;
    wire clki = ~clko;
    
    reg [24:0] count = 0;
    
    always @ (posedge(clko)) count <= count + 1;
     
    assign led = count[24];
    
   // IOBUF: Single-ended Bi-directional Buffer
   //        All devices
   // Xilinx HDL Language Template, version 2020.2

   IOBUF #(
      .DRIVE(12), // Specify the output drive strength
      .IBUF_LOW_PWR("TRUE"),  // Low Power - "TRUE", High Performance = "FALSE" 
      .IOSTANDARD("DEFAULT"), // Specify the I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) IOBUF_inst (
      .O(clko),     // Buffer output
      .IO(clkio),     // Buffer inout port (connect directly to top-level port)
      .I(clki),     // Buffer input
      .T(1'b0)      // 3-state enable input, high=input, low=output
   );

   // End of IOBUF_inst instantiation

endmodule
