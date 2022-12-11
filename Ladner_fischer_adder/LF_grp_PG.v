`timescale 1ns / 1ps
module LF_grp_PG #(parameter WIDTH = 16, VALENCY = 2)(
    input [WIDTH:0] G,
    input [WIDTH:0] P,
    output [WIDTH:0] Gi
    );
    parameter LEVELS = $clog2(WIDTH);
    
    wire [WIDTH-1:0] gt[0:LEVELS], pt[0:LEVELS];
    
    assign gt[0] = G;
    assign pt[0] = P;
    assign Gi[0] = G[0];
    
    genvar i, j, k, p;
    generate
        for(i = 0; i < LEVELS; i = i+1) begin: Levels
            if(i == 0) begin
                for(j = 1; j < WIDTH; j = j+1) begin: Top_cells_gen
                    if(j ==1) begin
                        Gray_cell #(VALENCY) GC_T(gt[i][j-:VALENCY], pt[i][j-:VALENCY], gt[i+1][j]);
                        assign Gi[j] = gt[i+1][j];
                    end
                    else begin
                        if(j%2 == 0) begin
                            assign gt[i+1][j]= G[j];
                            assign pt[i+1][j] = P[j];
                        end
                        Black_cell #(VALENCY) BC_T(gt[i][j-:VALENCY], pt[i][j-:VALENCY], gt[i+1][j], pt[i+1][j]);
                    end   
                end
            end
            else begin
                for(j = 2**i+1; j < WIDTH; j = j+2**(i+1)) begin: Upper
                    for(k = j; k < j+2**i; k = k+2) begin: Upper_cell_gen
                        if(k == j) begin
                            Gray_cell #(VALENCY) GC_T({gt[i][k],Gi[j-2]}, pt[i][k-:VALENCY], Gi[k]);
                            assign gt[i+1][k] = Gi[k];
                        end
                        else begin
                            Black_cell #(VALENCY) BC_T({gt[i][k],gt[i][j-2]}, {pt[i][k],pt[i][j-2]}, gt[i+1][k], pt[i+1][k]);
                        end
                    end
                    for(p = j+2**i; (p < WIDTH) && (p < j+2**(i+1)); p = p+1) begin: Wire_conn
                            assign gt[i+1][p] = gt[i][p];
                            assign pt[i+1][p] = pt[i][p];
                    end
                end
            end
        end
    endgenerate
    
    generate
        for(j = 2; j < WIDTH; j = j+2) begin: End_GC_gen
            Gray_cell #(VALENCY) GC_E({G[j],Gi[j-1]}, {P[j],1'b0}, Gi[j]);
        end
    endgenerate
    
    Gray_cell #(VALENCY) GC1({G[WIDTH],Gi[WIDTH-1]}, {P[WIDTH],1'b0}, Gi[WIDTH]);
endmodule
