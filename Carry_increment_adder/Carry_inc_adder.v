`timescale 1ns / 1ps
module Carry_inc_adder #(parameter WIDTH = 16, VALENCY = 2, GROUP = 4) (
    input [WIDTH:1] A,
    input [WIDTH:1] B,
    input Cin,
    output [WIDTH:1] S
    );
    wire [WIDTH:0] G, P, Gi;
    
    Bitwise_PG #(WIDTH) bit_PG(A, B, Cin, G, P);
    
    Carry_inc_grp_PG #(WIDTH, VALENCY, GROUP) grp_PG(G, P, Gi);
    
    Final_sum #(WIDTH) sum_logic(P, Gi, S);
endmodule