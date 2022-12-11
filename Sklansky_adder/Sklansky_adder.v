`timescale 1ns / 1ps
module Sklansky_adder #(parameter WIDTH = 16, VALENCY = 2)(
    input [WIDTH:1] A,
    input [WIDTH:1] B,
    input Cin,
    output [WIDTH:1] S,
    output Cout
    );
    wire [WIDTH:0] G, P, Gi;
    
    Bitwise_PG #(WIDTH) bit_PG(A, B, Cin, G, P);
    
    Sklansky_grp_PG #(WIDTH, VALENCY) grp_PG(G, P, Gi);
    
    Final_sum #(WIDTH) sum_logic(P, Gi, S);
    
    assign Cout = Gi[WIDTH];
endmodule
