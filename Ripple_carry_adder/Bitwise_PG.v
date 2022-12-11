`timescale 1ns / 1ps
module Bitwise_PG #(parameter WIDTH = 16)(
    input [WIDTH:1] A,
    input [WIDTH:1] B,
    input Cin,
    output [WIDTH:0] G,
    output [WIDTH:0] P
    );
    assign P[0] = 0;
    assign G[0] = Cin;
    
    genvar i;
    generate
        for(i = 1; i <= WIDTH; i = i+1) begin: bitwise_pg
            xor x(P[i], A[i], B[i]);
            and a(G[i], A[i], B[i]);
        end
    endgenerate    
        
endmodule
