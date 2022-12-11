`timescale 1ns / 1ps
module Adder_tb();
    parameter WIDTH = 8, VALENCY = 2;
    reg [WIDTH:1] A, B; reg Cin; wire [WIDTH:1] S; wire Cout;
    Knowles_adder #(WIDTH, VALENCY) DUT(A, B, Cin, S, Cout);
    
    initial begin
        A = 16'hffff; B = 1; Cin = 0;
        #5 A = 999; B = 1; Cin = 0;
        #5 A = 10000; B = 40000; Cin = 1;
        #5 $stop;
    end
endmodule
