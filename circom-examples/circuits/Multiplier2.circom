pragma circom  2.0.0;

template Multiplier2() {
    // Signals 
    signal input a;
    signal input b;
    //signal input c;
    signal output c;

    // Constraints
    c <== a*b;
}

component main = Multiplier2();