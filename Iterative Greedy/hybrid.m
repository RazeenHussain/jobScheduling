close all;
clear all;
clc;

timeLimit=600;
[P,W,D,S]=extractData('wt_sds_120.instance');


%seq1=[51 	5 	48 	9 	11 	57 	45 	27 	37 	40 	6 	24 	18 	36 	19 	25 	10 	30 	7 	54 	23 	15 	59 	8 	50 	56 	43 	33 	2 	13 	21 	32 	44 	46 	31 	12 	1 	47 	58 	38 	26 	29 	4 	3 	52 	60 	39 	53 	49 	35 	14 	42 	28 	22 	41 	20 	55 	16 	17 	34];
seq1=[23 15 12 1 31 51 13 7 5 48 9 54 30 60 57 25 37 40 6 24 2 11 36 3 50 59 8 28 21 10 19 52 45 27 18 32 44 26 29 4 43 33 39 47 58 38 46 56 53 49 35 14 42 22 17 20 55 16 34 41];
seq60=[32 17 40 19 50 11 53 59 37 23 9 36 48 2 15 1 44 45 56 27 12 41 49 43 38 18 22 10 7 51 57 24 20 60 21 58 31 26 52 47 34 35 3 28 4 33 6 29 25 55 42 14 13 54 46 16 8 39 5 30];
seq120=[25 15 52 44 28 31 27 20 39 53 33 16 45 22 18 13 55 35 14 24 34 49 56 42 23 50 19 6 9 3 41 36 1 5 2 7 30 10 11 60 29 51 21 26 38 40 4 12 48 43 37 8 32 54 59 17 46 47 57 58];

sequence=seq120;
C = computeCompletionTime(sequence,P,S);
T = computeTardiness(C,D);
initialCost = computeCost(W,T);

factor=sum(P)/600;

fileID = fopen('logHyb120Try7.txt','w');

fprintf(fileID,'\r\n\r\nINITIAL SEQUENCE:\r\n\r\n');
fprintf(fileID,'%d \t',sequence);
fprintf(fileID,'\r\n\r\n\n');
fprintf(fileID,'%6s %20s\r\n','Time','Cost');
fprintf(fileID,'%6.0d %20d\r\n',0,initialCost);

bestSeq=sequence;
bestCost=initialCost;
startTime=cputime;

count=0;

while(1)
    removedJobs=uniqueRandomNumbers(60);
    remainingJobs=jobRemoval(bestSeq,removedJobs);
    for i=1:4
        bestPos=1;
        tempSeq=insert(1,removedJobs(i),remainingJobs);
        C = computeCompletionTime(tempSeq,P,S);
        T = computeTardiness(C,D);
        tempBest = computeCost(W,T);
        for j=2:(56+i)
            tempSeq=insert(j,removedJobs(i),remainingJobs);
            C = computeCompletionTime(tempSeq,P,S);
            T = computeTardiness(C,D);
            tempCost = computeCost(W,T);
            if (tempCost<tempBest)
                bestPos=j;
                tempBest=tempCost;
            end
        end
        remainingJobs=insert(bestPos,removedJobs(i),remainingJobs);
    end
    C = computeCompletionTime(remainingJobs,P,S);
    T = computeTardiness(C,D);
    tempCost = computeCost(W,T);
    elapsedTime=cputime-startTime;
    if (rand(1)<=exp(-(tempCost-bestCost)/factor))
%    if (tempCost<bestCost)
        bestSeq=remainingJobs;
        bestCost=tempCost;
        fprintf(fileID,'%6.0d %20d\r\n',elapsedTime,bestCost);
    end
    count=count+1;
    if (elapsedTime>timeLimit)
        break;
    end
end
fprintf(fileID,'\r\n\r\n\r\n\r\nBEST SEQUENCE:\r\n\r\n');
fprintf(fileID,'%d \t',bestSeq);
fprintf(fileID,'\r\n\r\n');
fclose(fileID);