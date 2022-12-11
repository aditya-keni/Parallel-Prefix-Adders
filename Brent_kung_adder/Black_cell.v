`timescale 1ns / 1ps
module Black_cell #(VALENCY = 4)(
    input [VALENCY:1] G,
    input [VALENCY:1] P,
    output Gout,
    output Pout
    );
    wire [VALENCY:1] g;
    wire [VALENCY-1:1] t;
    assign g[1] = G[1];
    genvar i;
    generate
        for(i = 1; i < VALENCY; i = i+1) begin: black_cell
            and A(t[i], g[i], P[i+1]);
            or O(g[i+1], t[i], G[i+1]);
        end
    endgenerate
    
    assign Pout = &P;
    assign Gout = g[VALENCY];
endmodule