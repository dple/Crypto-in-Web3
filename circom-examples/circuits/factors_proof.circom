pragma circom  2.1.6;

include "../node_modules/circomlib/circuits/comparators.circom";

template multiply() {

    // Declaration of signals.
    signal input in[2];
    signal output out;

    // Constraints.
    out <== in[0]*in[1];
}

template factors_proof() {
    signal input p;
    signal input q;
    signal input N;
    signal output out;

    // Constraints
    signal tmp <== multiply()([p, q]);
    out <== IsEqual()([tmp, N]);
}

component main = factors_proof();