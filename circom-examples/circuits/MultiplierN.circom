pragma circom  2.0.0;

template Multiplier2() {
    signal input in1;
    signal input in2;
    signal output out;

    // Constraint 
    in1 * in2 ==> out;
}

template MultiplierN(n) {
    signal input in[n];
    signal output out;

    component comp[n - 1];
    // Constraints
    comp[0] = Multiplier2();
    comp[0].in1 <== in[0];
    comp[0].in2 <== in[1];

    for(var i = 1; i < n - 1; i++) {        
        comp[i] = Multiplier2();
        comp[i].in1 <== comp[i - 1].out;
        comp[i].in2 <== in[i + 1];        
    }

    out <== comp[n - 2].out;
}

component main = MultiplierN(4);