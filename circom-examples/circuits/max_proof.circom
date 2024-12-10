pragma circom  2.1.6;

include "comparators.circom";

template MaxProof(size, nInputs) {
    signal input v;
    signal input s[nInputs];
    signal output out;          // out = 1 of v is max value of the set s, else out = 0

    var score = 0;
    signal gt[nInputs];
    signal ise[nInputs];

    // Constraints
    for(var i = 0; i < nInputs; i++) {
        gt[i] <== GreaterThan(size)([v, s[i]]);
        score += gt[i];
        ise[i] <== IsEqual()([v, s[i]]);
        score += ise[i];
    }

    out <== IsEqual()([score, nInputs]);
}

component main = MaxProof(8, 10);