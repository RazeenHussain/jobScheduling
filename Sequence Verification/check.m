clear all;
close all;

sequence=[43 23 9 56 27 2 45 19 12 38 18 10 7 53 59 37 48 15 24 22 40 50 28 32 1 21 60 41 49 44 3 20 58 11 57 26 47 34 31 52 36 35 51 17 25 4 33 6 29 55 42 14 13 39 46 8 5 16 30 54];
[P,W,D,S]=extractData('wt_sds_60.instance');
C = computeCompletionTime(sequence,P,S);
T = computeTardiness(C,D);
Cost = computeCost(W,T);
