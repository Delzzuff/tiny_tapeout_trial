`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:35:40 04/02/2020 
// Design Name: 
// Module Name:    multiplier_8b 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: Module_EM_1b,Module_PG,Module_AHA,Module_AFA,Module_OR_3,Module_OR_4,Module_422_Comp,Module_FA
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module multiplier_8b(
    input [7:0] A,
    input [7:0] B,
    output [15:0] Product
    );

wire [7:0] A7,A6,A5,A4,A3,A2,A1,A0;
wire [14:3] X,Y;
wire [4:0] P7,G7,P5,G5;
wire [5:0] P6,G6;
wire [3:0] P4,G4;
wire [2:0] P3,G3;
wire P21,G21;
wire S12,S11,S10,S9,S8,S7,S6,S5,S4,G011,G010,G09,G08,G07,G06,G05,G04,G03,C12,C11,C10,C9,C8,C7,C6,C5,C4,S1,C1;
wire [6:1] CER;
wire [9:1] CE;
wire Cout;
wire [15:0]J,K;
//Multiplying elements of A with elements of B
Module_EM_1b m0(A[0],B,A0);
Module_EM_1b m1(A[1],B,A1);
Module_EM_1b m2(A[2],B,A2);
Module_EM_1b m3(A[3],B,A3);
Module_EM_1b m4(A[4],B,A4);
Module_EM_1b m5(A[5],B,A5);
Module_EM_1b m6(A[6],B,A6);
Module_EM_1b m7(A[7],B,A7);

//Generating 'propogate' and 'generate' signals
Module_PG g1(A7[4],A4[7],P7[4],G7[4]);
Module_PG g2(A7[3],A3[7],P7[3],G7[3]);
Module_PG g3(A7[2],A2[7],P7[2],G7[2]);
Module_PG g4(A7[1],A1[7],P7[1],G7[1]);
Module_PG g5(A7[0],A0[7],P7[0],G7[0]);
Module_PG g6(A6[5],A5[6],P6[5],G6[5]);
Module_PG g7(A6[4],A4[6],P6[4],G6[4]);
Module_PG g8(A6[3],A3[6],P6[3],G6[3]);
Module_PG g9(A6[2],A2[6],P6[2],G6[2]);
Module_PG g10(A6[1],A1[6],P6[1],G6[1]);
Module_PG g11(A6[0],A0[6],P6[0],G6[0]);
Module_PG g12(A5[4],A4[5],P5[4],G5[4]);
Module_PG g13(A5[3],A3[5],P5[3],G5[3]);
Module_PG g14(A5[2],A2[5],P5[2],G5[2]);
Module_PG g15(A5[1],A1[5],P5[1],G5[1]);
Module_PG g16(A5[0],A0[5],P5[0],G5[0]);
Module_PG g17(A4[3],A3[4],P4[3],G4[3]);
Module_PG g18(A4[2],A2[4],P4[2],G4[2]);
Module_PG g19(A4[1],A1[4],P4[1],G4[1]);
Module_PG g20(A4[0],A0[4],P4[0],G4[0]);
Module_PG g21(A3[2],A2[3],P3[2],G3[2]);
Module_PG g22(A3[1],A1[3],P3[1],G3[1]);
Module_PG g23(A3[0],A0[3],P3[0],G3[0]);
Module_PG g24(A2[1],A1[2],P21,G21);

//Applying approximate circuits
Module_AHA g33(P4[0],P3[1],S4,C4);
Module_AFA g36(P5[0],P4[1],P3[2],S5,C5);
or g39(G04,G4[0],G3[1]);
or g3A(G03,G3[0],G21);
Module_OR_3 g3D(G6[0],G5[1],G4[2],G06);
Module_OR_3 g3E(G5[0],G4[1],G3[2],G05);
Module_OR_4 g3F(G7[0],G6[1],G5[2],G4[3],G07);
PAC g311(P7[0],P6[1],P5[2],P4[3],S7,C7);
PAC g312(P6[0],P5[1],P4[2],A3[3],S6,C6);

//Applying exact circuits from column 8 onwards
Module_HA g31(A7[5],A5[7],S12,CE[9]);
Module_HA g37(G7[4],G6[5],G011,CE[8]);
Module_HA g32(P7[4],P6[5],S11,CE[7]);
Module_HA g38(G7[3],G6[4],G010,CE[6]);
Module_FA g34(P7[3],P6[4],A5[5],S10,CE[5]);
Module_FA g3B(G7[2],G6[3],G5[4],G09,CE[4]);
Module_FA g35(P7[2],P6[3],P5[4],S9,CE[3]);
Module_FA g3C(G7[1],G6[2],G5[3],G08,CE[2]);
Module_422_Comp_Exact g310(P7[1],P6[2],P5[3],A4[4],1'b0,S8,CE[1],Cout);

//Resolving the carries from row 8 onwards
Module_FA g321(CE[1],CE[2],Cout,C8,CER[1]);
Module_FA g322(CE[3],CE[4],CER[1],C9,CER[2]);
Module_FA g323(CE[5],CE[6],CER[2],C10,CER[3]);
Module_FA g324(CE[7],CE[8],CER[3],C11,CER[4]);
Module_HA g325(CE[8],CER[4],C12,CER[5]);

//Using approximate full adder and half adder to simplify the rows
Module_AHA g41(A2[0],A0[2],S1,C1);
//Module_AHA g42(S1,A1[1],X[2],Y[3]);
Module_AFA g43(P3[0],P21,G03,X[3],Y[4]);
Module_AFA g44(S4,A2[2],G04,X[4],Y[5]);
Module_AFA g45(S5,G05,C4,X[5],Y[6]);
Module_AFA g46(S6,G06,C5,X[6],Y[7]);
Module_AFA g47(S7,G07,C6,X[7],Y[8]);
Module_FA g48(S8,G08,C7,X[8],Y[9]);
Module_FA g49(S9,G09,C8,X[9],Y[10]);
Module_FA g4A(S10,G010,C9,X[10],Y[11]);
Module_FA g4B(S11,G011,C10,X[11],Y[12]);
Module_FA g4C(S12,C11,A6[6],X[12],Y[13]);
Module_FA g4D(A7[6],A6[7],C12,X[13],Y[14]);
Module_HA g4E(A7[7],CER[5],X[14],CER[6]);
//assign X[1] = A1[0];
//assign Y[1] = A0[1];
//assign Y[2] = 1'b0;
//assign Res[0] = A0[0];
assign Y[3] = C1;


// assign Product[0] = O1[0];
         assign K[0]=A0[0];
         assign J[0]=0;

         assign K[1]=A1[0];
         assign J[1]=A0[1];

         assign K[2]=S1;
         assign J[2]=A1[1];

         assign K[3]=X[3];
         assign J[3]=Y[3];

         assign K[4]=X[4];
         assign J[4]=Y[4];

         assign K[5]=X[5];
         assign J[5]=Y[5];

         assign K[6]=X[6];
         assign J[6]=Y[6];
         
	 assign K[7]=X[7];
         assign J[7]=Y[7];
	
         assign K[8]=X[8];
         assign J[8]=Y[8];
	 
         assign K[9]=X[9];
         assign J[9]=Y[9];
	 
	 assign K[10]=X[10];
         assign J[10]=Y[10];

         assign K[11]=X[11];
         assign J[11]=Y[11];

	 assign K[12]=X[12];
         assign J[12]=Y[12];

	 assign K[13]=X[13];
         assign J[13]=Y[13];

	 assign K[14]=X[14];
         assign J[14]=Y[14];

         assign K[15]=CER[6];
         assign J[15]=0;
	 KGAdder16Bits ghhhh( K, J,Product);






//Adding X and Y using an exact ripple-carry adder
//Module_HA g51(A1[0],A0[1],Res[1],C[1]);
//Module_FA g52(S1,A1[1],C[1],Res[2],C[2]);
//Module_FA g53(X[3],Y[3],C[2],Res[3],C[3]);
////Module_FA g54(X[4],Y[4],C[3],Res[4],C[4]);
//Module_FA g55(X[5],Y[5],C[4],Res[5],C[5]);
//Module_FA g56(X[6],Y[6],C[5],Res[6],C[6]);
//Module_FA g57(X[7],Y[7],C[6],Res[7],C[7]);
//Module_FA g58(X[8],Y[8],C[7],Res[8],C[8]);
//Module_FA g59(X[9],Y[9],C[8],Res[9],C[9]);
//Module_FA g5A(X[10],Y[10],C[9],Res[10],C[10]);
//Module_FA g5B(X[11],Y[11],C[10],Res[11],C[11]);
//Module_FA g5C(X[12],Y[12],C[11],Res[12],C[12]);
//Module_FA g5D(X[13],Y[13],C[12],Res[13],C[13]);
//Module_FA g5E(X[14],Y[14],C[13],Res[14],C[14]);
//Module_HA g5F(CER[6],C[14],Res[15],OV);
wire _unused = &{CE[9], 1'b0};
endmodule 





module Module_HA(
    input A,
    input B,
    output S,
    output C
    );

//Calculating sum
xor g1(S,A,B);

//Calculating carry
and g2(C,A,B);

endmodule





module Module_422_Comp_Exact(
    input A1,
    input A2,
    input A3,
    input A4,
	 input Cin,
    output S,
    output C,
    output Cout
    );

wire SC;

//Adding lower bits
Module_FA g1(A1,A2,A3,SC,Cout);

//Adding with A4
Module_FA g2(SC,A4,Cin,S,C);

endmodule





module Module_FA(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
    );
    
    wire w1,w2,w3;
    
    xor x1(w1, A, B);
    xor x2(Sum, w1, Cin); //Sum
    and a1(w3, Cin, w1);
    and a2(w2, A, B);
    or o1(Cout, w2, w3); //Carry
endmodule


module PAC(
    input X1,
    input X2,
    input X3,
    input X4,
    output sum,
    output carry
);
wire C1,C2,C3,C4,C5,C11,C12,C13;
wire S1,S2,S3,S4;

// Implementing C proposed
    and A1 (C1,X1,X2);
   // and A2 (C2,X1,X3);
    and A3 (C3,X3,X4);
   // and A4 (C4,X2,X3);
   // and A5 (C5,X2,X4);
   // or  O1 (C11,C1,C2);
   // or  O2 (C12,C3,C4);
  //  or  O3 (C13,C11,C12);
    or  O4 (carry,C3,C1);   

// Implementing S proposed
    xor XA1 (S1,X1,X2);
    xor  O5 (S2,X3,X4);
    and A34 (S3,C1,C3);
    or XA2 (S4,S1,S2);
    or ada (sum,S4,S3);
    wire _unused = &{C1,C2,C3,C4,C5,C11,C12,C13,1'b0};
    assign {C2, C4, C5, C11, C12, C13} = 6'b0;


endmodule




module KGAdder16Bits(
    input [15:0] A,
    input [15:0] B,
    output [15:0] Sum
    );

wire [15:0] Layer0G;
wire [15:0] Layer0P;
wire [15:0] Layer1G;
wire [15:0] Layer1P;
wire [15:0] Layer2G;
wire [15:0] Layer2P;
wire [15:0] Layer3G;
wire [15:0] Layer3P;

wire G00,G10,G20,G30,G40,G50,G60,G70,G80,G90,G100,G110,G120,G130,G140,G150;

wire _unused = &{G150,Layer0G,Layer0P,Layer1G,Layer1P,Layer2G,Layer2P,Layer3G,Layer3P,1'b0};
assign Layer3G[3:0] = 4'b0000;
assign Layer3P[7:0] = 8'b00000000;
assign Layer2G[1:0] = 2'b00;
assign Layer2P[3:0] = 4'b0000;
assign Layer1G[0]   = 1'b0;
assign Layer1P[1:0] = 2'b00;


//Level-0
    genvar i;
	 generate 
	 for(i=0;i<=15;i=i+1) begin
	 assign Layer0G[i]=A[i]&B[i];
	 end
	 endgenerate 
	 
	 genvar j;
	 generate 
	 for(j=0;j<=15;j=j+1) begin
	 assign Layer0P[j]=A[j]^B[j];
	 end
	 endgenerate 
//Level-1
    Buffer b1 (Layer0G[0],G00);	 
	 Grey_Cell gc1 (Layer0G[1],Layer0P[1],Layer0G[0],Layer1G[1]);	 
	 Black_Cell bc1 (Layer0G[2],Layer0P[2],Layer0G[1],Layer0P[1],Layer1G[2],Layer1P[2]);
	 Black_Cell bc2 (Layer0G[3],Layer0P[3],Layer0G[2],Layer0P[2],Layer1G[3],Layer1P[3]);
	 Black_Cell bc3 (Layer0G[4],Layer0P[4],Layer0G[3],Layer0P[3],Layer1G[4],Layer1P[4]);
	 Black_Cell bc4 (Layer0G[5],Layer0P[5],Layer0G[4],Layer0P[4],Layer1G[5],Layer1P[5]);
	 Black_Cell bc5 (Layer0G[6],Layer0P[6],Layer0G[5],Layer0P[5],Layer1G[6],Layer1P[6]);
	 Black_Cell bc6 (Layer0G[7],Layer0P[7],Layer0G[6],Layer0P[6],Layer1G[7],Layer1P[7]);
	 Black_Cell bc7 (Layer0G[8],Layer0P[8],Layer0G[7],Layer0P[7],Layer1G[8],Layer1P[8]);
	 Black_Cell bc8 (Layer0G[9],Layer0P[9],Layer0G[8],Layer0P[8],Layer1G[9],Layer1P[9]);
	 Black_Cell bc9 (Layer0G[10],Layer0P[10],Layer0G[9],Layer0P[9],Layer1G[10],Layer1P[10]);
	 Black_Cell bc10 (Layer0G[11],Layer0P[11],Layer0G[10],Layer0P[10],Layer1G[11],Layer1P[11]);
	 Black_Cell bc11 (Layer0G[12],Layer0P[12],Layer0G[11],Layer0P[11],Layer1G[12],Layer1P[12]);
	 Black_Cell bc12 (Layer0G[13],Layer0P[13],Layer0G[12],Layer0P[12],Layer1G[13],Layer1P[13]);
	 Black_Cell bc13 (Layer0G[14],Layer0P[14],Layer0G[13],Layer0P[13],Layer1G[14],Layer1P[14]);
	 Black_Cell bc14 (Layer0G[15],Layer0P[15],Layer0G[14],Layer0P[14],Layer1G[15],Layer1P[15]);
	 
//Level-2	 
	 Buffer b2 (Layer1G[1],G10);	
	 Grey_Cell gc2 (Layer1G[2],Layer1P[2],G00,Layer2G[2]);
	 Grey_Cell gc3 (Layer1G[3],Layer1P[3],Layer1G[1],Layer2G[3]);
	 Black_Cell bc15 (Layer1G[4],Layer1P[4],Layer1G[2],Layer1P[2],Layer2G[4],Layer2P[4]);
	 Black_Cell bc16 (Layer1G[5],Layer1P[5],Layer1G[3],Layer1P[3],Layer2G[5],Layer2P[5]);
	 Black_Cell bc17 (Layer1G[6],Layer1P[6],Layer1G[4],Layer1P[4],Layer2G[6],Layer2P[6]);
	 Black_Cell bc18 (Layer1G[7],Layer1P[7],Layer1G[5],Layer1P[5],Layer2G[7],Layer2P[7]);
	 Black_Cell bc19 (Layer1G[8],Layer1P[8],Layer1G[6],Layer1P[6],Layer2G[8],Layer2P[8]);
	 Black_Cell bc20 (Layer1G[9],Layer1P[9],Layer1G[7],Layer1P[7],Layer2G[9],Layer2P[9]);
	 Black_Cell bc21 (Layer1G[10],Layer1P[10],Layer1G[8],Layer1P[8],Layer2G[10],Layer2P[10]);
	 Black_Cell bc22 (Layer1G[11],Layer1P[11],Layer1G[9],Layer1P[9],Layer2G[11],Layer2P[11]);
	 Black_Cell bc23 (Layer1G[12],Layer1P[12],Layer1G[10],Layer1P[10],Layer2G[12],Layer2P[12]);
	 Black_Cell bc24 (Layer1G[13],Layer1P[13],Layer1G[11],Layer1P[11],Layer2G[13],Layer2P[13]);
	 Black_Cell bc25 (Layer1G[14],Layer1P[14],Layer1G[12],Layer1P[12],Layer2G[14],Layer2P[14]);
	 Black_Cell bc26 (Layer1G[15],Layer1P[15],Layer1G[13],Layer1P[13],Layer2G[15],Layer2P[15]);
	 
//Level-3
	 Buffer b3 (Layer2G[2],G20);
	 Buffer b4 (Layer2G[3],G30);
	 Grey_Cell gc4 (Layer2G[4],Layer2P[4],G00,Layer3G[4]);
	 Grey_Cell gc5 (Layer2G[5],Layer2P[5],G10,Layer3G[5]);
	 Grey_Cell gc6 (Layer2G[6],Layer2P[6],Layer2G[2],Layer3G[6]);
	 Grey_Cell gc7 (Layer2G[7],Layer2P[7],Layer2G[3],Layer3G[7]);
	 Black_Cell bc27 (Layer2G[8],Layer2P[8],Layer2G[4],Layer2P[4],Layer3G[8],Layer3P[8]);
	 Black_Cell bc28 (Layer2G[9],Layer2P[9],Layer2G[5],Layer2P[5],Layer3G[9],Layer3P[9]);
	 Black_Cell bc29 (Layer2G[10],Layer2P[10],Layer2G[6],Layer2P[6],Layer3G[10],Layer3P[10]);
	 Black_Cell bc30 (Layer2G[11],Layer2P[11],Layer2G[7],Layer2P[7],Layer3G[11],Layer3P[11]);
	 Black_Cell bc31 (Layer2G[12],Layer2P[12],Layer2G[8],Layer2P[8],Layer3G[12],Layer3P[12]);
	 Black_Cell bc32 (Layer2G[13],Layer2P[13],Layer2G[9],Layer2P[9],Layer3G[13],Layer3P[13]);
	 Black_Cell bc33 (Layer2G[14],Layer2P[14],Layer2G[10],Layer2P[10],Layer3G[14],Layer3P[14]);
	 Black_Cell bc34 (Layer2G[15],Layer2P[15],Layer2G[11],Layer2P[11],Layer3G[15],Layer3P[15]);
	
	 
	
//Level-4	
    Buffer b5 (Layer3G[4],G40);
	 Buffer b6 (Layer3G[5],G50);
	 Buffer b7 (Layer3G[6],G60);
	 Buffer b8 (Layer3G[7],G70);
	 Grey_Cell gc8 (Layer3G[8],Layer3P[8],G00,G80);
	 Grey_Cell gc9 (Layer3G[9],Layer3P[9],G10,G90);
	 Grey_Cell gc10 (Layer3G[10],Layer3P[10],G20,G100);
	 Grey_Cell gc11 (Layer3G[11],Layer3P[11],G30,G110);
	 Grey_Cell gc12 (Layer3G[12],Layer3P[12],Layer3G[4],G120);
	 Grey_Cell gc13 (Layer3G[13],Layer3P[13],Layer3G[5],G130);
	 Grey_Cell gc14(Layer3G[14],Layer3P[14],Layer3G[6],G140);
	 Grey_Cell gc15 (Layer3G[15],Layer3P[15],Layer3G[7],G150);
	 
	 
//Sum
	 assign Sum[0]=A[0]^B[0];
	 assign Sum[1]=Layer0P[1]^G00;
	 assign Sum[2]=Layer0P[2]^G10;	
	 assign Sum[3]=Layer0P[3]^G20;
	 assign Sum[4]=Layer0P[4]^G30;
	 assign Sum[5]=Layer0P[5]^G40;
	 assign Sum[6]=Layer0P[6]^G50; 	 
    assign Sum[7]=Layer0P[7]^G60;
	 assign Sum[8]=Layer0P[8]^G70;
	 assign Sum[9]=Layer0P[9]^G80;
	 assign Sum[10]=Layer0P[10]^G90;
	 assign Sum[11]=Layer0P[11]^G100;
	 assign Sum[12]=Layer0P[12]^G110;
	 assign Sum[13]=Layer0P[13]^G120;
	 assign Sum[14]=Layer0P[14]^G130;
	 assign Sum[15]=Layer0P[15]^G140;
	 //assign Sum[15]=G140;
		
	 

	endmodule

module Grey_Cell(
    input Gi,
    input Pi,
    input Giminus1toj,
    output Gitoj
    );
 assign Gitoj = Gi+Pi*Giminus1toj;

endmodule


module Black_Cell(
    input Gi,
    input Pi,
	 input Giminus1toj,
    input Piminus1toj,
    output Gitoj,
    output Pitoj
    );
	 
assign Gitoj = Gi+Pi*Giminus1toj;
assign Pitoj=Pi*Piminus1toj;

endmodule


module Buffer(
    input in,
    output out
    );
	 assign out=in;
endmodule

module Module_EM_1b(
    input A,
    input [7:0] B,
    output [7:0] Res
    );

//Multiplying A into B
and g1(Res[0],A,B[0]);
and g2(Res[1],A,B[1]);
and g3(Res[2],A,B[2]);
and g4(Res[3],A,B[3]);
and g5(Res[4],A,B[4]);
and g6(Res[5],A,B[5]);
and g7(Res[6],A,B[6]);
and g8(Res[7],A,B[7]);

endmodule 


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:58:47 04/03/2020 
// Design Name: 
// Module Name:    Module_PG 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Module_PG(
    input A,
    input B,
    output P,
    output G
    );

//Generating 'generate' signal
and g1(G,A,B);

//Generating 'propogate' signal
or g2(P,A,B);

endmodule 



`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:01:35 04/03/2020 
// Design Name: 
// Module Name:    Module_AHA 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Module_AHA(
    input A,
    input B,
    output S,
    output C
    );

//Calculate approximate sum
or g1(S,A,B);

//Calculate approximate carry
and g2(C,A,B);

endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:02:48 04/03/2020 
// Design Name: 
// Module Name:    Module_AFA 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Module_AFA(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
    );

wire W;

//Calculate W
or g1(W,A,B);

//Calculate approximate sum
xor g2(S,W,Cin);

//Calculate approximate 
and g3(Cout,W,Cin);

endmodule 

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:10:07 04/03/2020 
// Design Name: 
// Module Name:    Module_OR_3 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Module_OR_3(
    input A0,
    input A1,
    input A2,
    output S
    );

wire W;

//Calculating bitwise OR of operands
or g1(W,A0,A1);
or g2(S,A2,W);

endmodule 

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:07:33 04/03/2020 
// Design Name: 
// Module Name:    Module_OR_4 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Module_OR_4(
    input A0,
    input A1,
    input A2,
    input A3,
    output S
    );

wire W1,W2;

//Calculating bitwise OR of operands
or g1(W1,A0,A1);
or g2(W2,A2,W1);
or g3(S,A3,W2);

endmodule 

