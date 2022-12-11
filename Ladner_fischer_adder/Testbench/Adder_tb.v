`timescale 1ns / 1ps
module Adder_tb();

    parameter WIDTH = 128, VALENCY = 2;
    
    reg [WIDTH:1] A, B; reg Cin; wire [WIDTH:1] S; wire Cout;
    
    Ladner_fischer_adder #(WIDTH, VALENCY) DUT(A, B, Cin, S, Cout);
    
    initial begin
        A = 10000; B = 5000; Cin = 0;
        #5 A = 16'hffff; B = 0; Cin = 1;
        #5 A = 10000; B = 55000; Cin = 1;
        #5 $stop;
    end
endmodule
