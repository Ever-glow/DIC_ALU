`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/01 03:10:05
// Design Name: 
// Module Name: aluTb
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

`define		AluMultiply		4'b0000
`define		AluAdd			4'b0010
`define		AluSub			4'b0011
`define		AluAND			4'b0100
`define		AluNAND			4'b0101
`define		AluOR			4'b0110
`define		AluNOR			4'b0111
`define		AluRor			4'b1010
`define		AluRol			4'b1011
`define		AluNOT			4'b1100
`define		AluShl			4'b1101
`define		AluShr			4'b1110

module aluTb;
    
    reg     [3:0] Inst;
    reg     [7:0] A;
    reg     [7:0] BusWires;
    wire    [7:0] check;
    wire    [7:0] Result;
    
    alu alu0 (.Inst(Inst), .A(A), .BusWires(BusWires), .Result(Result), .check(check));
    
    initial begin
        Inst    = 4'b1111;
    end
     
    initial begin
        //Multiply
        #0      Inst = `AluMultiply; A = 8'b00000100; BusWires = 8'b00000010;
        #5      if (check == A * BusWires) begin
                    $display("Multiply: success");
                end
                else begin
                    $display("Multiply: fail");
                    $display("%b", check);
                end   
        #100    Inst = `AluMultiply; A = 8'b00001000; BusWires = 8'b00000100; 
        #5      if (check == A * BusWires) begin
                    $display("Multiply: success");
                end
                else begin
                    $display("Multiply: fail");
                    $display("%b", check);
                end
                
        //Add
        #100    Inst = `AluAdd; A = 8'b00010001; BusWires = 8'b01; 
        #5      if (check == A + BusWires) begin
                    $display("Add: success");
                end
                else begin
                    $display("Add: fail");
                    $display("%b", check);
                end
        #100    Inst = `AluAdd; A = 8'b01011111; BusWires = 8'b01100000; 
        #5      if (check == A + BusWires) begin
                    $display("Add: success");
                end
                else begin
                    $display("Add: fail");
                    $display("%b", check);
                end
                
        //Sub
        #100    Inst = `AluSub; A = 8'b00111101; BusWires = 8'b01;
        #5      if (check == A - BusWires) begin
                    $display("Sub: success");
                end
                else begin
                    $display("Sub: fail");
                    $display("%b", check);
                end
        #100    Inst = `AluSub; A = 8'b00011100; BusWires = 8'b00001100; 
        #5      if (check == A - BusWires) begin
                    $display("Sub: success");
                end
                else begin
                    $display("Sub: fail");
                    $display("%b", check);
                end
                 
        //AND
        #100    Inst = `AluAND; A = 8'b00111101; BusWires = 8'b01110001; 
        #10     if (check == Result) begin
                    $display("AND: success");
                end
                else begin
                    $display("AND: fail");
                    $display("%b", check);
                end
        #100    Inst = `AluAND; A = 8'b10111111; BusWires = 8'b0;
        #10     if (check == A & BusWires) begin
                    $display("AND: success");
                end
                else begin
                    $display("AND: fail");
                    $display("%b", check);
                end
                 
        //NAND
        #100    Inst = `AluNAND; A = 8'b00111101; BusWires = 8'b01;
        #5      if (check == ~(A & BusWires)) begin
                    $display("NAND: success");
                end
                else begin
                    $display("NAND: fail");
                    $display("%b", check);
                end 
        #100    Inst = `AluNAND; A = 8'b00111111; BusWires = 8'b1;
        #5      if (check == ~(A & BusWires)) begin
                    $display("NAND: success");
                end
                else begin
                    $display("NAND: fail");
                    $display("%b", check);
                end
                 
        //OR
        #100    Inst = `AluOR; A = 8'b00111101; BusWires = 8'b01;
        #5      if (check == A | BusWires) begin
                    $display("OR: success");
                end
                else begin
                    $display("OR: fail");
                    $display("%b", check);
                end 
        #100    Inst = `AluOR; A = 8'b10111101; BusWires = 8'b0; 
        #5      if (check == A | BusWires) begin
                    $display("OR: success");
                end
                else begin
                    $display("OR: fail");
                    $display("%b", check);
                end
                
        //NOR
        #100    Inst = `AluNOR; A = 8'b00111101; BusWires = 8'b01;
        #5      if (check == ~(A | BusWires)) begin
                    $display("NOR: success");
                end
                else begin
                    $display("NOR: fail");
                    $display("%b", check);
                end 
        #100    Inst = `AluNOR; A = 8'b10111101; BusWires = 8'b00011111;
        #5      if (check == ~(A | BusWires)) begin
                    $display("NOR: success");
                end
                else begin
                    $display("NOR: fail");
                    $display("%b", check);
                end
                 
        //Ror
        #100    Inst = `AluRor; A = 8'b00000001; BusWires = 8'b0;
        #5      if (check == {A[0], A[7:1]}) begin
                    $display("Ror: success");
                end
                else begin
                    $display("Ror: fail");
                    $display("%b", check);
                end 
        #100    Inst = `AluRor; A = 8'b00011110; BusWires = 8'b0;
        #5      if (check == {A[0], A[7:1]}) begin
                    $display("Ror: success");
                end
                else begin
                    $display("Ror: fail");
                    $display("%b", check);
                end
                 
        //Rol
        #100    Inst = `AluRol; A = 8'b00000001; BusWires = 8'b0;
        #5      if (check == {A[6:0], A[7]}) begin
                    $display("Rol: success");
                end
                else begin
                    $display("Rol: fail");
                    $display("%b", check);
                end 
        #100    Inst = `AluRol; A = 8'b00011110; BusWires = 8'b0;
        #5      if (check == {A[6:0], A[7]}) begin
                    $display("Rol: success");
                end
                else begin
                    $display("Rol: fail");
                    $display("%b", check);
                end
                 
        //NOT
        #100    Inst = `AluNOT; A = 8'b00111101; BusWires = 8'b0;
        #5      if (check == ~(A)) begin
                    $display("NOT: success");
                end
                else begin
                    $display("NOT: fail");
                    $display("%b", check);
                end 
        #100    Inst = `AluNOT; A = 8'b01001111; BusWires = 8'b0;
        #5      if (check == ~(A)) begin
                    $display("NOT: success");
                end
                else begin
                    $display("NOT: fail");
                    $display("%b", check);
                end
                 
        //Shl
        #100    Inst = `AluShl; A = 8'b00000001; BusWires = 8'b0;
        #5      if (check == {A[6:0], 1'b0}) begin
                    $display("Shl: success");
                end
                else begin
                    $display("Shl: fail");
                    $display("%b", check);
                end 
        #100    Inst = `AluShl; A = 8'b00011110; BusWires = 8'b0;
        #5      if (check == {A[6:0], 1'b0}) begin
                    $display("Shl: success");
                end
                else begin
                    $display("Shl: fail");
                    $display("%b", check);
                end
                 
        //Shr
        #100    Inst = `AluShr; A = 8'b00000001; BusWires = 8'b0;
        #5      if (check == {1'b0, A[7:1]}) begin
                    $display("Shr: success");
                end
                else begin
                    $display("Shr: fail");
                    $display("%b", check);
                end 
        #100    Inst = `AluShr; A = 8'b00011110; BusWires = 8'b0;
        #5      if (check == {1'b0, A[7:1]}) begin
                    $display("Shr: success");
                end
                else begin
                    $display("Shr: fail");
                    $display("%b", check);
                end 
            
    end
            
endmodule