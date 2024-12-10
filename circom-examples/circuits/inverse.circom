pragma circom  2.1.6;

include "comparators.circom";

template Inverse() {
    // Declaration of signals.
    signal input in;
    signal output out;
    assert(in != 0);

    // Constraints.
    signal inv <-- 1/in;

    component isz = IsEqual();
    isz.in[0] <== 1;
    isz.in[1] <== in*inv;
    isz.out === 1;
    out <== inv;
}

component main = Inverse();
