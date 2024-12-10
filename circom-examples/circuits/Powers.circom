pragma circom  2.1.6;

template Powers(nOuts) {
    signal input a;
    signal output powers[nOuts];

    powers[0] <== a;
    for (var i = 1; i < nOuts; i++) {
        powers[i] <== powers[i - 1] * a;
    }
}

//component main = Powers(8);