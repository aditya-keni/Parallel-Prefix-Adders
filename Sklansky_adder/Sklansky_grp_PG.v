`timescale 1ns / 1ps
module Sklansky_grp_PG #(parameter WIDTH = 16, VALENCY = 2)(
    input [WIDTH:0] G,
    input [WIDTH:0] P,
    output [WIDTH:0] Gi
    );
    parameter LEVELS = $clog2(WIDTH);
    
    wire [WIDTH-1:0] gt[0:LEVELS], pt[0:LEVELS];
    
    assign Gi[0] = G[0];
    assign gt[0] = G;
    assign pt[0] = P;
    
    genvar i, j, k, p;
    generate
        for(i = 0; i < LEVELS; i = i+1) begin: Levels
            for(j = 2**i; j <= WIDTH-2**i; j = j+2**(i+1)) begin: Cell_positions
                for(k = j; k < j+2**i; k = k+1) begin: Cell_gen
                        if(j == 2**i) begin
                            Gray_cell #(VALENCY) GC({gt[i][k],Gi[j-1]}, pt[i][k-:VALENCY], Gi[k]);
                            assign gt[i+1][k] = Gi[k];
                            assign pt[i+1][k] = pt[i][k];
                        end
                        else
                            Black_cell #(VALENCY) BC({gt[i][k],gt[i][j-1]}, {pt[i][k],pt[i][j-1]}, gt[i+1][k], pt[i+1][k]);
                        for(p = j+2**i; (p < WIDTH) && (p < j+2**(i+1)); p = p+1) begin: Wire_conn
                            assign gt[i+1][p] = gt[i][p];
                            assign pt[i+1][p] = pt[i][p];
                        end
                end
            end
        end     
    endgenerate
    
    Gray_cell #(VALENCY) GC1({G[WIDTH],Gi[WIDTH-1]}, {P[WIDTH],1'b0}, Gi[WIDTH]);


//    wire [WIDTH-1:1] gt[0:WIDTH/2], pt[0:WIDTH/2];
    
//    assign Gi[0] = G[0];
//    assign gt[0] = G[15:1];
//    assign pt[0] = P[15:1];
    
//    genvar i, j, k, p;
//    generate
//        for(i = 1; i <= WIDTH/2; i = 2*i) begin: Loop_i
        
//            for(j = i; j <= WIDTH-i; j = j+2*i) begin: Loop_j
            
//                for(k = j; k < j+i; k = k+1) begin: Loop_k
                
//                    if(j == i) begin
//                        Gray_cell #(VALENCY) GC({gt[i/2][k],Gi[j-1]}, pt[i/2][k-:VALENCY], Gi[k]);
//                        assign gt[i][k] = Gi[k];
//                        assign pt[i][k] = pt[i/2][k];
//                    end
                    
//                    else begin
//                        Black_cell #(VALENCY) BC({gt[i/2][k],gt[i/2][j-1]}, {pt[i/2][k],pt[i/2][j-1]}, gt[i][k], pt[i][k]);
//                    end
//                end
//                for(p = j+i; (p < WIDTH) && (p < j+2*i); p = p+1) begin: Loop_xxx
//                    assign gt[i][p] = gt[i/2][p];
//                    assign pt[i][p] = pt[i/2][p];
//                end    
//            end
//        end
//    endgenerate
endmodule