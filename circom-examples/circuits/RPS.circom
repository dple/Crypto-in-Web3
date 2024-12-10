pragma circom  2.1.6;

include "../node_modules/circomlib/circuits/comparators.circom";

/*
 Rock=0
 Paper=1
 Scissors=2

 x | y | out
 -----------
 0 | 2 | 0
 0 | 0 | 1
 0 | 1 | 2
 1 | 0 | 0
 1 | 1 | 1
 1 | 2 | 2
 2 | 1 | 0
 2 | 2 | 1
 2 | 0 | 2
*/ 

// Checks if input x is a valid rock-paper-scissors value (0,1,2)
template AssertIsRPS() {
    signal input x;
    signal RP <== (x - 0) * (x - 1);
    signal RPS <== RP * (x - 2);
}

// Returns the score for a single round, given the plays by x and y
template Round() {
    signal input x, y;
    signal output out;

    // Validate inputs
    AssertIsRPS()(x);
    AssertIsRPS()(y);

    // check if draw
    signal isDraw <== IsEqual()([x, y]);

    signal diffXY <== (y + 3) - x;

    // y win if y - x == 1 mod 3
    signal yWin1 <== (diffXY - 1) * (diffXY - 4);
    signal yWin <== IsZero()(yWin1);

    // x win if y - x == 2 mod 3
    signal xWin1 <== (diffXY - 2) * (diffXY - 5);
    signal xWin <== IsZero()(xWin1);

    // Check the integrity of result
    signal xOrYWin <== (xWin - 1) * (yWin);
    xOrYWin * isDraw === 0;
    xWin + yWin + isDraw === 1;
  
    // score is 6 if y wins, 3 if draw, 0 if x wins
    // plus 1, 2, 3 depending on the choice of RPS
    out <== yWin * 6 + isDraw * 3 + y + 1;
}

template Game(n) {
    signal input xs[n];
    signal input ys[n];
    signal scores[n];
    signal output out;

    var score = 0;
    for(var i = 0; i < n; i++) {
        scores[i] <== Round()(xs[i], ys[i]);
        score += scores[i];
    }

    out <== score;
}

component main = Game(3);