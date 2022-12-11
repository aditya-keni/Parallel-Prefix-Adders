`timescale 1ns / 1ps
module RCA #(parameter WIDTH = 16, VALENCY = 2)(
    input [WIDTH:1] A,
    input [WIDTH:1] B,
    input Cin,
    output [WIDTH:1] S,
    output Cout
    );
    wire [WIDTH:0] G, P, Gi;
    
    Bitwise_PG #(WIDTH) B_PG(A, B, Cin, G, P);
    
    Group_PG #(WIDTH, VALENCY) G_PG(G, P, Gi);
    
    Final_sum #(WIDTH) F_sum(P, Gi, S);
    
    assign Cout = Gi[WIDTH];
endmodule
