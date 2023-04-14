`include "adder.v"
`include "subtractor.v"

module control(clk, enb, modo, A, B, Q, RCO);

    // Define inputs
    input clk, enb;
    input [1:0] modo;
    input [3:0] A, B;

    /* Define ouputs:
        Equivalent to (diff, bout) and (sum, cout)
    */
    output reg [3:0] Q;
    output reg RCO;

    

endmodule