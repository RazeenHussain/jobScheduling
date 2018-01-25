close all;
clc;
clear all;
M=10000;
dimX=60+60+(60*60);
dimA=59*59*60;
varName=cell(dimX,1);
for i=1:60
    varName(i)={strcat('Tardiness',num2str(i))};
end
for i=1:60
    varName(i+60)={strcat('Completion',num2str(i))};
end
k=1;
for i=1:60
    for j=1:60
        varName(k+120)={strcat('JobPosition',num2str(i),',',num2str(j))};
        k=k+1;    
    end
end
varType=[repmat('N',120,1);repmat('B',3600,1)];
varSense=[repmat('<',60,1);repmat('>',60,1);repmat('=',60,1);repmat('=',60,1);repmat('>',dimA,1)];
save('varInfo','M','varName','varType','varSense');