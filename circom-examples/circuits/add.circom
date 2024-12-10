pragma circom  2.0.0;

include "comparators.circom";

template Add() {
    signal input in[2];    
    signal output out;

    //constraints    
    out <-- in[0] + in[1];
    component ise = IsEqual();
    ise.in[0] <== out;
    ise.in[1] <== in[0] - in[1];
    1 === ise.out;
}

component main = Add();