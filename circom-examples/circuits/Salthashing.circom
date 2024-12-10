pragma circom  2.1.6;

include "../node_modules/circomlib/circuits/mimcsponge.circom";

template SaltHashing() {
    signal input a;
    signal input b;
    signal input salt;
    signal output out;

    // Constraints
    component msponge = MiMCSponge(3, 220, 1);
    msponge.ins[0] <== a;
    msponge.ins[1] <== b;
    msponge.ins[2] <== salt;
    out <== msponge.outs[0];
}

component main = SaltHashing();