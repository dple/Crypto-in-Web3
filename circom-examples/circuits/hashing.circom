pragma circom  2.0.0;

include "../node_modules/circomlib/circuits/poseidon.circom"

template hashing() {
    signal input l; // public
    signal input r;
    signal output out;

    component hash = poseidon(2);
    hash.inputs[0] <== l;
    hash.inputs[1] <== r;

    out <== hash.out;
}

component main {public [l]} = hashing()