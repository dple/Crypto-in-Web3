pragma circom  2.0.0;

include "comparators.circom";

template Average(nInputs) {
    signal input inputs[nInputs];
    signal output out;
    signal n_inv;

    var sum = 0;
    // Constraints
    n_inv <-- 1/nInputs;
    for(var i = 0; i < nInputs; i++) {
        sum += inputs[i];
    }

    component ise = IsEqual();
    ise.in[0] <== 1;
    ise.in[1] <== nInputs * n_inv;

    out <== sum * n_inv;
}

component main = Average(5);