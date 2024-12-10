pragma circom 2.1.6;

include "comparators.circom";

template EqualN(n) {
    signal input in[n];
    signal output out;  // out = 1 if all inputs are equal, else = 0
    
    signal isEq[n - 1];    
    var score = 0;

    for (var i = 0; i < n - 1; i++) {
        isEq[i] <== IsEqual()([in[i], in[i + 1]]);
        score += isEq[i];        
    }    
        
    out <== IsEqual()([score, (n - 1)]);
}

component main = EqualN(5);