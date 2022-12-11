`timescale 1ns / 1ps
module Adder_tb();
    parameter WIDTH = 16, VALENCY = 2;
    reg [WIDTH:1] A, B; reg Cin; wire [WIDTH:1] S;
    RCA #(WIDTH, VALENCY) DUT(A, B, Cin, S, Cout);
    
    initial begin
        A = 110; B = 6145; Cin = 0;
        #5 A = 4000; B = 6000; Cin = 1;
        #5 A = 10000; B = 40000; Cin = 1;
        #5 $stop;
    end
endmodule
