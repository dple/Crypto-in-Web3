pragma circom  2.1.6;

include "PolyEval.circom";

template Poly_roots(d) {
    signal input a[d + 1];  // coefficients
    signal input x[d];      // d solutions
    signal output out;      // out = 1 if all solutions are correct, else out = 0;
 
    component polyeval[d];
    var score = 0;
    
    for (var j = 0; j < d; j++) {
        polyeval[j] = PolyEval(d);

        for(var i = 0; i < d + 1; i++) {
            polyeval[j].a[i] <== a[i];
        }

        polyeval[j].x <== x[j];
        polyeval[j].res <== 0;
        polyeval[j].out === 1;
        score += polyeval[j].out;
    }
    
    out <-- score * 1/d;
    out === 1;
}

component main = Poly_roots(5);