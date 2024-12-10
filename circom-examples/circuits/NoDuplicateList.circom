pragma circom  2.1.6;

include "List_sorted_proof.circom";

template NoDuplicateList(size, nInputs) {
    signal input list[nInputs];
    signal output out;

    component sortedList = ListSorted(size, nInputs);

    for (var i = 0; i < nInputs; i++) {
        sortedList.in[i] <== list[i];
    }

    1 === sortedList.out;
    
    var score = 0;
    signal ise[nInputs - 1];
    for (var i = 0; i < nInputs - 1; i++) {
        ise[i] <== IsEqual()([list[i], list[i+1]]);
        score += ise[i];
    }

    out <== IsEqual()([0, score]);
}

component main = NoDuplicateList(8, 10);