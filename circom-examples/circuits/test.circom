pragma circom  2.0.0;

include "../node_modules/circomlib/circuits/comparators.circom";

template test() {
    //signal input enabled;
    signal input in;
    signal output out;

    out <== in*5;
    signal inv <-- 1/5;
    component ise = IsEqual();
    ise.in[0] <== in;
    ise.in[1] <== out * inv;

    1 - ise.out === 0;
}

component main = test();