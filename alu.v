`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/01 03:09:05
// Design Name: 
// Module Name: alu
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


/* ALU Instructions*/

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

module alu (Inst, A, BusWires, Result, check);

    input   [3:0]   Inst;
    input   [7:0]   A, BusWires;
    
    wire    [3:0]   Inst;
    wire    [7:0]   A, BusWires;
    
    output   [7:0]   Result;
    output   [7:0]   check;
    
    reg     [7:0]   Result, check;
    reg             Zout, Sout, Cout;
    
    always @(Inst or A or BusWires or Result or check) begin
        Zout    = 1'b0;
        Sout    = 1'b0;
        Cout    = 1'b0;
        Result  = 8'b0;
        check   = 8'b0;
        
        case (Inst)
            `AluMultiply:   begin
                    {Cout, Result} = (A * BusWires);
                    check = (A * BusWires);                 
                    if (Result == 8'h00)
                        Zout = 1'b1;
                    if (Result[7] == 1)
                        Sout = 1'b1;
                end
                
            `AluShl: begin  Result = {A[6:0], 1'b0}; 
                            check = {A[6:0], 1'b0}; end
            `AluShr: begin  Result = {1'b0, A[7:1]};
                            check = {1'b0, A[7:1]}; end
            `AluRol: begin  Result = {A[6:0], A[7]};
                            check = {A[6:0], A[7]}; end
            `AluRor: begin  Result = {A[0], A[7:1]};
                            check = {A[0], A[7:1]}; end
            
            `AluAdd:    begin
                    {Cout, Result} = (A + BusWires);
                    check = (A + BusWires);
                    if (Result == 8'h00)
                        Zout = 1'b1;
                    if (Result[7] == 1)
                        Sout = 1'b1;
                end
            
            `AluSub:    begin
                    {Cout, Result} = (A - BusWires);
                    check = (A - BusWires);
                    if (Result == 8'h00)
                        Zout = 1'b1;
                    if (Result[7] == 1)
                        Sout = 1'b1;
                end
            
            `AluAND : begin  Result = A & BusWires;
                             check = A & BusWires;  end
            `AluNAND: begin  Result = ~(A & BusWires);
                             check = ~(A & BusWires);  end
            `AluOR  : begin  Result = A | BusWires;
                             check = A | BusWires;  end
            `AluNOR :  begin  Result = ~(A | BusWires);
                              check = ~(A | BusWires);  end
            `AluNOT :  begin  Result = ~(A);
                              check = ~(A);  end
            default :   begin
                    Zout    = 1'b0;
                    Sout    = 1'b0;
                    Cout    = 1'b0;
                    Result  = 8'b0;
                end
        endcase
    end              
endmodule
