`timescale 1ns / 1ps
module Final_sum #(parameter WIDTH = 16)(
    input [WIDTH:0] P,
    input [WIDTH:0] Gi,
    output [WIDTH:1] S,
    output Cout
    );
    genvar i;
    generate
        for(i = 1; i <= WIDTH; i = i+1) begin: final_sum
            xor x(S[i], P[i], Gi[i-1]);
        end
    endgenerate
    
    assign Cout = Gi[WIDTH]; 
endmodule
