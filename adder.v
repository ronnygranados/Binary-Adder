module adder(a, b, cin, q, cout);

    // Module inputs
    input a, b, cin;

    // Module outputs
    output q, cout;

    // Module operations

    /* SUM operation */
    assign q = a ^ b ^ cin;

    /* CARRY-OUT operation */
    assign cout = (a & b) | (cin & a) | (cin & b);

endmodule

// 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