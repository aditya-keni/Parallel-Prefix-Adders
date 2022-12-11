`timescale 1ns / 1ps
module Gray_cell #(parameter VALENCY = 2)(
    input [VALENCY-1:0] G,
    input [VALENCY-1:0] P,
    output Gout
    );
    wire [VALENCY-1:0]g, t;
    assign g[0] = G[0];
    genvar i;
    generate
        for(i = 1; i < VALENCY; i = i + 1) begin: gray_cell
            and a(t[i], P[i], g[i-1]);
            or o(g[i], t[i], G[i]); 
        end
    endgenerate
    
    assign Gout = g[VALENCY-1];
endmodule