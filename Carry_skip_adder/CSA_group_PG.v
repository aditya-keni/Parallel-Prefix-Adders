`timescale 1ns / 1ps
module Carry_skip_group_PG #(parameter WIDTH = 16, VALENCY = 2, GROUP = 4)(
    input [WIDTH:0] G,
    input [WIDTH:0] P,
    output [WIDTH:0] Gi
    );
    wire [WIDTH:1] t; wire [WIDTH:0] muxout;
    
    assign Gi[0] = G[0];
    assign muxout[0] = G[0];
    
    genvar i, j;    
    generate
        for(i = 2; i <= WIDTH-2; i = i+GROUP) begin: upp_gc
            assign t[i-1] = G[i-1];
            for(j = 0; j < GROUP-1; j = j+1) begin: upp_gc_in
                Gray_cell #(VALENCY) GC_up({G[i+j], t[i+j-1]}, P[i+j:i+j-1], t[i+j]);
            end
        end
    endgenerate
    

    generate
        for(i = 1; i <= WIDTH-3; i = i+GROUP) begin: low_gc
            for(j = 0; j < GROUP-1; j = j+1) begin: log_gc_in
                Gray_cell #(VALENCY) GC_low({G[i+j], Gi[i+j-1]}, P[i+j:i+j-1], Gi[i+j]);
            end
        end
    endgenerate
    
    generate
        for(i = GROUP; i <= WIDTH; i = i+GROUP) begin: mux_gen
            assign muxout[i] = &P[i:i-GROUP+1] ? muxout[i-GROUP] : t[i];
            assign Gi[i] = muxout[i];
        end
    endgenerate
endmodule