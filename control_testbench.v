`include "control.v"

/*
    In this module we think of the dising as
    a physical thing, with input and output
    ports connected internally to the modules
    we created to add and subtract, controlled
    by the control.v module
*/

module testbench;

    // Inputs
    reg clk, enb;
    reg [1:0] modo;
    reg [3:0] A, B;

    // Outputs
    wire [3:0] Q;
    wire RCO;

    control uut(.clk(clk),
                .enb(enb),
                .modo(modo),
                .A(A), .B(B),
                .Q(Q),
                .RCO(RCO));
    
        initial begin
            $dumpfile("control_testbench.vcd");
            $dumpvars(0, control_testbench);

            // Now we test our module

            A = 4'b0000; B = 4'b0000; enb = 0; modo = 2'b00; #10;


        end

        always begin
            clk = 1; #5;
            clk = 0; #5;
            $display ("A = %b, B = %b, enb = %b, modo = %b", A, B, enb, modo);
        end

endmodule