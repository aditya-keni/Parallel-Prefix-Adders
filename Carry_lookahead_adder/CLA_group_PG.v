`timescale 1ns / 1ps
module CLA_group_PG #(parameter WIDTH = 16, VALENCY = 2, GROUP = 4)(
    input [WIDTH:0] G,
    input [WIDTH:0] P,
    output [WIDTH:0] Gi
    );
    
    assign Gi[0] = G[0];
    
    genvar i, j;    
    generate
        for(i = GROUP; i <= WIDTH; i = i+GROUP) begin: upp_gc
            wire g, p;
            Black_cell #(.VALENCY(GROUP)) BC(G[i-:GROUP], P[i-:GROUP], g, p);
            Gray_cell #(VALENCY) GC1({g, Gi[i-GROUP]}, {p, 1'b0}, Gi[i]);
        end
    endgenerate
    
    generate
        for(i = 1; i < WIDTH; i = i+GROUP) begin: low_gc
            for(j = i; j < i+GROUP; j = j+1) begin: GC_gen
                Gray_cell #(VALENCY) GC2({G[j], Gi[j-1]}, P[j:j-1], Gi[j]);
            end
        end
    endgenerate
endmodule
