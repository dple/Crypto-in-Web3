/**
 *  The circuits are copied from comparators.circom in circomlib
 */

pragma circom  2.0.0;

include "bits.circom";

template IsZero() {
    signal input in;
    signal output out;

    signal inv;
    // constrainsts
    inv <-- in != 0? 1/in: 0;
    out <== 1 - in * inv;
    out * in === 0;
}

template NonZero() {
    signal input  in;
    signal inv;
    signal output out;

    // Constrainst
    inv <-- in != 0 ? 1 / in : 0;

    out <== in * inv;
    (1 - out) * in === 0;
}

template IsEqual() {
    signal input in[2];
    signal output out;

    // Constrainsts
    out <== IsZero()(in[0]- in[1]);
}

template NotEqual() {
    signal input in[2];
    signal output out; // if not equal, output 1, else output 0

    // Constraints
    signal ise <== IsEqual()([in[0], in[1]]);
    out <== 1 - ise;
    out*ise === 0;
}

template ForcedEqual() {
    signal input enabled;
    signal input in[2];

    signal isz <== IsEqual()([in[0], in[1]]);

    (1 - isz)*enabled === 0;
}

template LessThan(n) {
    assert(n <= 252);   // the size of the prime field operated
    signal input in[2];
    signal output out;  // out = 1 if in[0] < in[1], otherwise out = 0

    component n2b = N2b(n+1);

    n2b.in <== in[1] + (1 << n) - in[0];
    out <== n2b.out[n];
}

template LessThanEqual(n) {
    signal input in[2]; 
    signal output out; // out = 1 if in[0] <= in[1], otherwise out = 0

    out <== LessThan(n)([in[0], in[1] + 1]);
}


template GreaterThan(n) {
    assert(n <= 252);
    signal input in[2];
    signal output out; // out = 1 if in[0] > in[1], otherwise out = 0

    // Constraints
    component n2b = N2b(n+1);

    n2b.in <== in[0] + (1 << n) - in[1];
    out <== n2b.out[n];
}

template GreaterThanEqual(n) {
    signal input in[2];
    signal output out;

    out <== GreaterThan(n)([in[0], in[1] + 1]);
}

//component main = GreaterThanEqual(8);