/* localsolver jobScheduling.lsp inFileName=instances/data_1.in lsTimeLimit=30 solFileName=logLS_1.txt */

/* ********* jobScheduling.lsp **********/

use io;

/* Reads instance data. */
function input() {
    local usage = "Usage: localsolver jobScheduling.lsp "
        + "inFileName=inputFile [solFileName=outputFile] [lsTimeLimit=timeLimit]";

    if (inFileName == nil) throw usage;

    local inFile = io.openRead(inFileName);
    processTimes[0] = 0;
    weights[0] = 0;
    deadlines[0] = 0;
    for [i in 0..60] setupTimes[i][0] = 0;
    processTimes[i in 1..60] = inFile.readInt();
    weights[i in 1..60] = inFile.readInt();
    deadlines[i in 1..60] = inFile.readInt();
    setupTimes[i in 0..60][j in 1..60] = inFile.readInt(); 
}

/* Declares the optimization model. */
function model() {
    // sequence variable 
    sequence <- list(61);
    constraint count(sequence) == 61;
    constraint sequence[0] == 0;

    // completion time constraint
    completionTimes[0] = 0;
    completionTimes[i in 1..60] <- setupTimes[sequence[i-1]][sequence[i]]+processTimes[sequence[i]]+completionTimes[i-1];

    // tardiness constraint
    tardiness[i in 0..60] <- max(0,(completionTimes[i] - deadlines[sequence[i]]));

    // minimize value
    objectiveValue <- sum[i in 0..60](weights[sequence[i]] * tardiness[i]);
    minimize objectiveValue;
}

/* Parameterizes the solver. */
function param() {
    if (lsTimeLimit == nil) lsTimeLimit = 20; 
}

/* Writes the solution in a file */
function output() {
    if(solFileName == nil) return;
    local solFile = io.openWrite(solFileName);
    solFile.println(objectiveValue.value);
    for [i in sequence.value] 
        solFile.print(i, " ");
    solFile.println();
}
