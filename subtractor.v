module subtractor(x, y, bin, diff, bout);

    // Inputs
    input x, y, bin;

    // Outputs
    output diff, bout;

    // Operations

    /* DIFF logic operation*/
    assign diff = x ^ y ^ bin;

    /* Bout logic operation*/
    assign bout = (~x & y) | (~x & bin) | (y & bin);

endmodule