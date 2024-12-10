pragma circom 2.1.6;

include "../node_modules/circomlib/circuits/mimcsponge.circom";

template HashLeftRight() {
    signal input left;
    signal input right;
    signal output hash;

    component hasher = MiMCSponge(2, 1);
    hasher.in[0] <== left;
    hasher.in[1] <== right;
    hasher.k <== 0;

    out <== hasher.outs[0];
}

// if s == 0 returns [in[0], in[1]]
// if s == 1 returns [in[1], in[0]]
template DualMux() {
    signal input in[2];
    signal input s;
    signal output out[2];

    s * (1 -s) === 0;
    out[0] <== (in[1] - in[0])*s + in[0];
    out[1] <== (in[0] - in[1])*s + in[1];
}

template GetMerkleRoot(levels) {
    signal input leaf;                  // A merkle leaf
    signal input pathElements[levels];  // Authentication path (hashes) from leaf to root
    signal input pathIndices[levels];   // Authentication path indices (0 or 1)  from leaf to root
    signal output root;                 // Output Merkle root 

    
}


// Verifies that merkle proof is correct for given merkle root and a leaf
// pathIndices input is an array of 0/1 selectors telling whether given pathElement is on the left or right side of merkle path
template MerkleTreeChecker(levels) {
    signal input leaf;                  // Merkle leaf
    signal input root;                  // Merkle root
    signal input pathElements[levels];   // Authentication path (hashes) from leaf to root
    signal input pathIndices[levels];   // Authentication path indices (0 or 1)  from leaf to root

    component selectors[levels];
    component hashers[levels];

    for(var i = 0; i < levels; i++) {
        selectors[i] = DualMux();
        selectors[i].in[0] <== i == 0 ? leaf : hashers[i - 1].hash;
        selectors[i].in[1] <== pathElements[i];
        selectors[i].s <== pathIndices[i];

        hashers[i] = HashLeftRight();
        hashers[i].left <== selectors[i].out[0];
        hashers[i].right <== selectors[i].out[1];
    }

    root === hashers[levels - 1].hash;
}

component main = MerkleTreeChecker(3);