pragma circom  2.1.6;

include "comparators.circom";

template Over18() {
    signal input age;
    signal output out;

    out <== GreaterThanEqual(7)([age, 18]);
}

component main = Over18();