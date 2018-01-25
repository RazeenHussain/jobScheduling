close all;
clear all;
clc;

[P,W,D,S]=extractData('wt_sds_1.instance');
load('varInfo');

dimX=60+60+(60*60);
dimA=240+(59*59*60);
varObj = zeros(1,dimX);
for i=1:60
    varObj(i)=W(i);
end

varA = zeros(dimA,dimX);
varRHS = zeros(dimA,1);

% t >= c - d
varA(1:60,1:120) = [(-1*eye(60)) eye(60)]; 
varRHS(1:60,1) = D; 

% c >= p + s - M(1 - x)
varA(61:120,61:120) = eye(60);
for i=1:60
    varA((60+i),(121+(i-1)*60)) = -1*M;
end
varRHS(61:120,1)=P'+S(1,:)-(repmat(M,60,1))';

% sum x = 1
for i=1:60
    j=121+((i-1)*60);
    varA((120+i),(j:1:(j+59))) = ones(1,60);
end
varA(181:240,121:3720) = repmat(eye(60),1,60);
varRHS(121:240,1)=ones(120,1);

% c >= p + s + c - M(2 - x - x)
count = 241;
temp=zeros(60,60);
for i=1:60
    for j=1:60
        for k=2:60
            if i ~= j
                varRHS(count)=P(j)+S((i+1),j)-(2*M);
                varA(count,(60+j))=1;
                varA(count,(60+i))=-1;
                temp(i,(k-1))=-1*M;
                temp(j,k)=-1*M;
                adhoc=reshape(temp',1,[]);
                varA(count,121:3720)=adhoc;
                temp(i,(k-1))=0;
                temp(j,k)=0;
                count=count+1;
            end
        end
    end
end

save('modelParam1','varA','varObj','varRHS','varSense','varType','varName','dimX','-v7.3');