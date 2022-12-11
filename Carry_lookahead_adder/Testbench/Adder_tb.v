`timescale 1ns / 1ps
module Adder_tb();
    parameter WIDTH = 16, VALENCY = 2, GROUP = 2;
    reg [WIDTH:1] A, B; reg Cin; wire [WIDTH:1] S; wire Cout;
    
    Carry_lookahead_adder #(WIDTH, VALENCY, GROUP) DUT(A, B, Cin, S, Cout);
    
    initial begin
        A = 16'hffff; B = 1; Cin = 0;
        #5 A = 55000; B = 7000; Cin = 1;
        #5 A = 999; B = 0; Cin = 1;
        #5 $stop;
    end
endmodule
