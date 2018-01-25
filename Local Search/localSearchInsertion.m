close all;
clear all;
clc;

timeLimit=15;
load('initialSequence1');
[P,W,D,S]=extractData('wt_sds_1.instance');

C = computeCompletionTime(sequence,P,S);
T = computeTardiness(C,D);
initialCost = computeCost(W,T);

fileID = fopen('logInsertion1.txt','w');
fprintf(fileID,'%6s %20s\r\n','Time','Cost');
fprintf(fileID,'%6s %20s\r\n',0,initialCost);
count=0;
bestSeq=sequence;
bestCost=initialCost;
startTime=cputime;
while(1)
    for i=1:60
        for j=1:60
            count=count+1;
            elapsedTime=cputime-startTime;
            if (i~=j)
                insertSeq=insertion(i,j,bestSeq);
                C = computeCompletionTime(insertSeq,P,S);
                T = computeTardiness(C,D);
                insertCost = computeCost(W,T);
                if (insertCost<bestCost)
                    i=0;
                    bestSeq=insertSeq;
                    bestCost=insertCost;
                    fprintf(fileID,'%6.0d %20d\r\n',elapsedTime,bestCost);
                    break;
                end
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