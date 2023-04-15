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
        $dumpvars(0, testbench);

        // Now we test our module

        // A = 4'b0000; B = 4'b0000; enb = 0; modo = 2'b00; #10; // Nothing happens, enb and modo are 0
        // A = 4'b0000; B = 4'b0000; enb = 1; modo = 2'b00; #10; // enb is 1, but mode 00 means it holds latest value
        // A = 4'b1000; B = 4'b0001; enb = 1; modo = 2'b01; #10; // 1000 + 0001 bc enb is 1 and mode is sum
        // A = 4'b1000; B = 4'b0001; enb = 1; modo = 2'b00; #10;

        A = 4'b0000; B = 4'b0000; enb = 0; modo = 2'b00; #20; // Todo cero
        A = 4'b0011; B = 4'b1100; enb = 0; modo = 2'b01; #20; // enb off, no hace nada
        A = 4'b0110; B = 4'b1001; enb = 1; modo = 2'b00; #20; // enb on, modo 00, no hace nada
        A = 4'b0000; B = 4'b0000; enb = 1; modo = 2'b00; #20; // 
        A = 4'b0001; B = 4'b0001; enb = 1; modo = 2'b01; #20; // Suma 1 + 1
        A = 4'b0011; B = 4'b0011; enb = 1; modo = 2'b01; #20; // Suma 3 + 3

        A = 4'b0000; B = 4'b0000; enb = 1; modo = 2'b01; #20; // Regreso a 0
        A = 4'b0100; B = 4'b1100; enb = 1; modo = 2'b01; #20; // 4 + 12: Rebase: Q = 0
        A = 4'b0100; B = 4'b0100; enb = 1; modo = 2'b01; #20; // 4 + 4: Q = 8
        A = 4'b0111; B = 4'b0001; enb = 1; modo = 2'b00; #20; // 7 + 1, pero modo 00, entonces Q = 8
        A = 4'b0001; B = 4'b0001; enb = 1; modo = 2'b00; #20; // 1 + 1, pero modo 00, entonces Q = 8 

        
        A = 4'b0000; B = 4'b0000; enb = 0; modo = 2'b00; #20; // Todo cero
        A = 4'b0011; B = 4'b1100; enb = 0; modo = 2'b10; #20; // enb off, no hace nada
        A = 4'b0011; B = 4'b0001; enb = 1; modo = 2'b10; #20; // 3 - 1
        A = 4'b1000; B = 4'b1001; enb = 1; modo = 2'b10; #20; // 8-9
        A = 4'b0110; B = 4'b0011; enb = 1; modo = 2'b00; #20; // 6-3, pero modo 00
        A = 4'b0110; B = 4'b1001; enb = 1; modo = 2'b11; #20; // enb on, modo 11, Q = 0

        #50
        $finish;

    end

    always begin
        clk = 1; #5;
        clk = 0; #5;
        $display ("A = %b, B = %b, enb = %b, modo = %b", A, B, enb, modo);
    end

endmodule