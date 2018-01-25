function [C] = computeCompletionTime(sequence,P,S)
C=zeros(60,1);
job=sequence(1);
C(job)=S(1,job)+P(job);
for i=2:60
    jobCurrent=sequence(i);
    jobPrevious=sequence(i-1);
    C(jobCurrent)=P(jobCurrent)+S((jobPrevious+1),jobCurrent)+C(jobPrevious);
end