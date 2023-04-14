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

    wire [3:0] ADD_Q;
    wire [3:0] ADD_COUT;

    wire [3:0] SUB_Q;
    wire [3:0] SUB_COUT;

    /*
        a -> A
        q -> sum_Q
        sum_Q -> Q; asi se podra instanciar en el TB
        cout -> sum_cout
        sum_cout -> RCO; para instanciar en el TB
    */

    adder add1(.a(A[0]), .b(B[0]), .q(ADD_Q[0]), cin(1'b0), cout(ADD_COUT[0]));
    adder add2(.a(A[1]), .b(B[1]), .q(ADD_Q[1]), cin(ADD_COUT[0]), cout(ADD_COUT[1]));
    adder add3(.a(A[2]), .b(B[2]), .q(ADD_Q[2]), cin(ADD_COUT[1]), cout(ADD_COUT[2]));
    adder add4(.a(A[3]), .b(B[3]), .q(ADD_Q[3]), cin(ADD_COUT[2]), cout(ADD_COUT[3]));

    subractor sub2(.a(A[1]), .b(B[1]), .q(SUB_Q[1]), bin(SUB_COUT[0]), bout(SUB_COUT[1]));
    subractor sub1(.a(A[0]), .b(B[0]), .q(SUB_Q[0]), bin(1'b0), bout(SUB_COUT[0]));
    subractor sub3(.a(A[2]), .b(B[2]), .q(SUB_Q[2]), bin(SUB_COUT[1]), bout(SUB_COUT[2]));
    subractor sub4(.a(A[3]), .b(B[3]), .q(SUB_Q[3]), bin(SUB_COUT[2]), bout(SUB_COUT[3]));


endmodule