`timescale 1ns / 1ps
module Carry_inc_grp_PG #(parameter WIDTH = 16, VALENCY = 2, GROUP = 4)(
    input [WIDTH:0] G,
    input [WIDTH:0] P,
    output [WIDTH:0] Gi
    );
    
    wire [WIDTH-1:0] g, p;
    
    assign Gi[0] = G[0];
    
    genvar i, j;
    generate
        for(i = 0; i < WIDTH; i = i+GROUP) begin: grp_PG
            if(i == 0) begin
                for(j = 1; j < GROUP; j = j+1) begin: Initial_GC_gen
                    Gray_cell #(VALENCY) GC_0({G[j], Gi[j-1]}, P[j:j-1], Gi[j]);
                end
            end
            else begin
                for(j = i; j < i+GROUP; j = j+1) begin: BC_GC_gen
                    if(j == i) begin
                        Gray_cell #(VALENCY) GC1({G[j], Gi[j-1]}, P[j:j-1], Gi[j]);
                        assign g[j] = G[j];
                        assign p[j] = P[j];
                    end
                    else begin
                        Black_cell #(VALENCY) BC2({G[j], g[j-1]}, {P[j], p[j-1]}, g[j], p[j]);
                        Gray_cell #(VALENCY) GC2({g[j], Gi[i-1]}, {p[j],1'b0}, Gi[j]);
                    end
                end
            end
        end
    endgenerate
endmodule
