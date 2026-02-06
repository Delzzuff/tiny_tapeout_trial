`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2026 12:17:58
// Design Name: 
// Module Name: multiplier_wrapper
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


module multiplier_8b_wrapper (
    input         clk,
    input         rst,
    input  [2:0]  comm,
    input  [7:0]  in_8b,
    output [7:0]  out_8b
);

    reg [7:0] A_reg;
    reg [7:0] B_reg;

    wire [15:0] Product_int;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A_reg <= 8'd0;
            B_reg <= 8'd0;
        end else begin
            if (comm == 3'd1)
                A_reg <= in_8b;
            if (comm == 3'd2)
                B_reg <= in_8b;
           
        end
    end

    multiplier_8b u_mult (
        .A(A_reg),
        .B(B_reg),
        .Product(Product_int)
    );

    reg [7:0] out_reg;

    always @(posedge clk or posedge rst) begin
        if (rst)
            out_reg <= 8'd0;
        else
            if (comm == 3'd3)  
                out_reg <= Product_int[7:0];
            else if (comm == 3'd4)  
                out_reg <= Product_int[15:8];
            else 
                out_reg <= 0;
            
    end

    assign out_8b = out_reg;

endmodule

