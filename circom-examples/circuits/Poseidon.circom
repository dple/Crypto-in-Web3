pragma circom  2.1.6;

include "../node_modules/circomlib/circuits/poseidon.circom";

template PoseidonHasher(n) {
    signal input in[n];
    signal output out;

    component poseidon = Poseidon(n);
    for (var i = 0; i < n; i++) {
        poseidon.inputs[i] <== in[i];
    }
    
    out <== poseidon.out;
}

component main = PoseidonHasher(4);
