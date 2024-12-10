pragma circom  2.1.6;

include "comparators.circom";

template range_proof(min, max) {
    assert(min <= max);
    signal input value;
    signal output out;

    signal get <== GreaterThanEqual(8)([value, min]);
    get === 1;
    signal let <== LessThanEqual(8)([value, max]);
    let === 1;

    out <== IsEqual()([get + let, 2]);
}

component main = range_proof(1, 99);