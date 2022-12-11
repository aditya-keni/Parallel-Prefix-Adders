`timescale 1ns / 1ps
module Adder_tb();
    parameter WIDTH = 16, VALENCY = 2, GROUP = 3;
    reg [WIDTH:1] A, B; reg Cin; wire [WIDTH:1] S;
    
    Carry_inc_adder #(WIDTH, VALENCY, GROUP) DUT(A, B, Cin, S);
    
    initial begin
        A = 1000; B = 5000; Cin = 0;
        #5 A = 16'hffff; B = 0; Cin = 1;
        #5 A = 999; B = 1; Cin = 0;
        #5 $stop;
    end
endmodule
