`timescale 1ns / 1ps
module Group_PG #(parameter WIDTH=16, VALENCY = 2)(
    input [WIDTH:0] G,
    input [WIDTH:0] P,
    output [WIDTH:0] Gi
    );
    assign Gi[0] = G[0];
    genvar i;
    generate
        for(i = 1; i <= WIDTH; i = i+1) begin: group_pg
            Gray_cell #(VALENCY) GC({G[i], Gi[i-1]}, P[i:i-1], Gi[i]);
        end
    endgenerate 
endmodule
