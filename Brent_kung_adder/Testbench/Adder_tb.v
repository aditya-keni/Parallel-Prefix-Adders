`timescale 1ns / 1ps
module Adder_tb();
    parameter WIDTH = 16, VALENCY = 2;
    
    reg [WIDTH:1] A, B; reg Cin; wire [WIDTH:1] S; wire Cout;
    
    Brent_kung_adder #(WIDTH, VALENCY) DUT(A, B, Cin, S, Cout);
    
    initial begin
        A = 16'hffff; B = 0; Cin = 1;
        #5 A = 4000; B = 6000; Cin = 1;
        #5 A = 1000000; B = 5500000; Cin = 1;
        #5 $stop;
    end
endmodule
