pragma circom  2.0.0;

include "comparators.circom";

template Division() {
    // a / b = q remainder r
    signal input a;
    signal input b;
    signal input q;
    signal input r;
    signal output out;  // out = 1 if the division was done properly, else out = 0

    signal ise <== IsEqual()([b*q + r, a]);
    ise === 1;
    signal lt <== LessThan(10)([r, b]);
    lt === 1;
    out <-- (ise + lt) * 1/2;
    out === 1;
}

component main = Division();