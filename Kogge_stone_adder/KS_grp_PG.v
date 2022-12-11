`timescale 1ns / 1ps
module KS_grp_PG #(parameter WIDTH = 16, VALENCY = 2)(
    input [WIDTH:0] G,
    input [WIDTH:0] P,
    output [WIDTH:0] Gi
    );
    parameter LEVELS = $clog2(WIDTH);
    
    wire [WIDTH-1:0] gt[0:LEVELS], pt[0:LEVELS];
    
    assign gt[0] = G;
    assign pt[0] = P;
    assign Gi[0] = G[0];
    
    genvar i, j;
    generate
        for(i = 0; i < LEVELS; i = i+1) begin: Levels
            for(j = 0; j < WIDTH; j = j+1) begin: Cells_gen
                if(j < 2**i)
                    assign gt[i+1][j] = gt[i][j];
                else if(j < 2**(i+1)) begin
                    Gray_cell #(VALENCY) GC({gt[i][j],gt[i][j-2**i]}, {pt[i][j],pt[i][j-2**i]}, gt[i+1][j]);
                    assign Gi[j] = gt[i+1][j];
                end
                else 
                    Black_cell #(VALENCY) BC({gt[i][j],gt[i][j-2**i]}, {pt[i][j],pt[i][j-2**i]}, gt[i+1][j], pt[i+1][j]);
            end
        end
    endgenerate

    Gray_cell #(VALENCY) GC1({G[WIDTH],Gi[WIDTH-1]}, {P[WIDTH],1'b0}, Gi[WIDTH]);
    
endmodule
