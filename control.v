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

    adder add1 (
        .a(A[0]), 
        .b(B[0]), 
        .q(ADD_Q[0]), 
        .cin(1'b0), 
        .cout(ADD_COUT[0]));
    
    adder add2 (.a(A[1]), .b(B[1]), .q(ADD_Q[1]), .cin(ADD_COUT[0]), .cout(ADD_COUT[1]));
    
    adder add3 (.a(A[2]), .b(B[2]), .q(ADD_Q[2]), .cin(ADD_COUT[1]), .cout(ADD_COUT[2]));
    
    adder add4 (.a(A[3]), .b(B[3]), .q(ADD_Q[3]), .cin(ADD_COUT[2]), .cout(ADD_COUT[3]));


    subtractor sub2 (.x(A[1]), .y(B[1]), .diff(SUB_Q[1]), .bin(1'b0), .bout(SUB_COUT[0]));
    subtractor sub1 (.x(A[0]), .y(B[0]), .diff(SUB_Q[0]), .bin(SUB_COUT[0]), .bout(SUB_COUT[1]));
    subtractor sub3 (.x(A[2]), .y(B[2]), .diff(SUB_Q[2]), .bin(SUB_COUT[1]), .bout(SUB_COUT[2]));
    subtractor sub4 (.x(A[3]), .y(B[3]), .diff(SUB_Q[3]), .bin(SUB_COUT[2]), .bout(SUB_COUT[3]));

    always @ (posedge clk) 
        
        if (enb == 1'b1) begin

          if (modo == 2'b01) begin
            Q <= ADD_Q;
            RCO <= ADD_COUT;
          end

          if (modo == 2'b10) begin
            Q <= SUB_Q;
            RCO <= SUB_COUT;
          end

          if (modo == 2'b11) begin
            Q <= 0;
            RCO <= 0;
          end

        end
  
endmodule