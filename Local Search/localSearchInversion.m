close all;
clear all;
clc;

timeLimit=15;
load('initialSequence120');
[P,W,D,S]=extractData('wt_sds_120.instance');

C = computeCompletionTime(sequence,P,S);
T = computeTardiness(C,D);
initialCost = computeCost(W,T);

fileID = fopen('logInversion120.txt','w');
fprintf(fileID,'%6s %20s\r\n','Time','Cost');
fprintf(fileID,'%6s %20s\r\n',0,initialCost);
count=0;
bestSeq=sequence;
bestCost=initialCost;
startTime=cputime;
while(1)
    for i=1:59
        for j=i+1:60
            count=count+1;
            elapsedTime=cputime-startTime;
            invertSeq=inversion(i,j,bestSeq);
            C = computeCompletionTime(invertSeq,P,S);
            T = computeTardiness(C,D);
            invertCost = computeCost(W,T);
            if (invertCost<bestCost)
                i=0;
                bestSeq=invertSeq;
                bestCost=invertCost;
                fprintf(fileID,'%6.0d %20d\r\n',elapsedTime,bestCost);
                break;
            end
            if (elapsedTime>timeLimit)
                break;
            end
        end
        if (elapsedTime>timeLimit)
            break;
        end
    end
    if (elapsedTime>timeLimit)
        disp('maxtime');
        fprintf(fileID,'Maximum Time\n');
        break;
    end
end
fprintf(fileID,'\r\n\r\n\r\n\r\nBEST SEQUENCE:\r\n\r\n');
fprintf(fileID,'%d \t',bestSeq);
fprintf(fileID,'\r\n\r\n');
fclose(fileID);