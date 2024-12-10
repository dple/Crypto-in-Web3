pragma circom  2.1.6;

include "comparators.circom";
include "Powers.circom";

template PolyEval(d) {
    signal input x;         // evaluated value
    signal input a[d + 1];  // coeefficients
    signal input res;       // result 
    signal output out;      // out = 1 if Poly(x) = res, else out = 0

    signal powers[d] <== Powers(d)(x);
    signal terms[d];
    var eval = a[0];
    // Constraints
    for (var i = 0; i < d; i++) {
        terms[i] <== a[i + 1]*powers[i];
        eval = eval + terms[i];
    }
    out <== IsEqual()([eval, res]);
}

//component main = PolyEval(3);   // Evaluate a cubic polynomial axˆ3 + bˆxˆ2 + cx + d