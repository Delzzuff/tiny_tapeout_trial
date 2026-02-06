`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2026 18:06:25
// Design Name: 
// Module Name: tt_Delzzuff_8b_approx_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tt_um_Delzzuff_8b_approx_multiplier(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
    );
    
    
    multiplier_8b_wrapper dut (
        .clk   (clk),
        .rst   (!rst_n),
        .comm  (comm),
        .in_8b (in_8b),
        .out_8b(out_8b)
    );
    wire [2:0] comm;
    wire [7:0] in_8b,out_8b;
    assign in_8b = ui_in;
    assign uo_out = out_8b;
    
    assign comm = uio_in[2:0];
    assign uio_oe = 8'b0; 
    wire _unused = &{ena,ui_in[7:3], 1'b0};
    assign uio_out = 8'b0;
endmodule
