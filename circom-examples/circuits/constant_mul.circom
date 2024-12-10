pragma circom  2.0.0;

include "../node_modules/circomlib/circuits/comparators.circom";

template constant_mul() {
    signal input in;
    signal output out;
    
    out <== in*5;
    signal inv <-- 1/5;

    component isz = IsZero();
    isz.in <== out*inv - in;
    1 - isz.out === 0;
}

component main = constant_mul();