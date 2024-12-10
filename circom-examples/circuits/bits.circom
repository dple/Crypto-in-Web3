/**
 *  The circuits are copied from bitify.circom in circomlib
 */
pragma circom  2.0.0;

template N2b(n) {
    signal input in;
    signal output out[n];

    var v = 0;
    var e = 1;

    for(var i = 0; i < n; i++) {
        out[i] <-- (n >> i) & 1;
        out[i]*(out[i] - 1) === 0;
        v += out[i]*e;
        e = e + e;
    }

    v === in;
}

//component main = N2b(8);