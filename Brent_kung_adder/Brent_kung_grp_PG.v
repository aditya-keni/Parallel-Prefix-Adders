`timescale 1ns / 1ps
module Brent_kung_grp_PG #(parameter WIDTH = 16, VALENCY = 2)(
    input [WIDTH:0] G,
    input [WIDTH:0] P,
    output [WIDTH:0] Gi
    );
    
    wire [WIDTH-1:0] gt1[0:$clog2(WIDTH)], pt1[0:$clog2(WIDTH)];
    
    assign gt1[0] = G;
    assign pt1[0] = P;
    assign Gi[0] = G[0];
    
    genvar i, j, k;
    generate
        for(i = 1; i <= $clog2(WIDTH); i = i+1) begin: Upper_Levels
            assign gt1[i][0] = G[0];
            for(j = 2**i-1; j < WIDTH; j = j+2**i) begin: Upper_cells_gen
                
                for(k = j-1; k >= j-(2**i-1); k = k-1) begin: wire_connnections
                    assign gt1[i][k] = gt1[i-1][k];
                    assign pt1[i][k] = pt1[i-1][k];
                end
                
                if(j==2**i-1) begin
                    Gray_cell #(VALENCY) GC({gt1[i-1][j],gt1[i-1][j-2**(i-1)]}, {pt1[i-1][j],pt1[i-1][j-2**(i-1)]}, gt1[i][j]);
                    assign Gi[j] = gt1[i][j];
                end
                else
                    Black_cell #(VALENCY) BC({gt1[i-1][j],gt1[i-1][j-2**(i-1)]}, {pt1[i-1][j],pt1[i-1][j-2**(i-1)]}, gt1[i][j], pt1[i][j]);
            end
        end
    endgenerate
    
    generate
        for(i = $clog2(WIDTH)-1; i > 0; i = i-1) begin: Lower_levels
            for(j = WIDTH-(2**(i-1)+1); j > 0; j = j-2**i) begin: GC_cells_gen
                if(j >= 2**i) 
                    Gray_cell #(VALENCY) GC_lower({gt1[$clog2(WIDTH)][j],Gi[j-2**(i-1)]}, {pt1[$clog2(WIDTH)][j],1'b0}, Gi[j]);
            end
        end
    endgenerate
    
    Gray_cell #(VALENCY) GC1({G[WIDTH],Gi[WIDTH-1]}, {P[WIDTH],1'b0}, Gi[WIDTH]);
endmodule
