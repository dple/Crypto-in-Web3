pragma circom  2.1.6;

include "comparators.circom";

template ListSorted(size, nInputs) {

    // Declaration of signals.
    signal input in[nInputs];
    signal output out; // return out = 1 if the list was sorted from least to greatest

    signal lte[nInputs - 1];
    var score = 0;
    // Constraints.
    for (var i = 0; i < nInputs - 1; i++) {
        lte[i] <== LessThanEqual(size)([in[i], in[i + 1]]);
        score += lte[i];
    }

    out <== IsEqual()([score, nInputs - 2]);
}

//component main = ListSorted(8, 5);
