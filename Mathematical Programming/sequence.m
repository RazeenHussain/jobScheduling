clear all;
close all;
clc;

load('result60_30min');
varX=result.x;
binX=(varX(121:3720))';
X2d=zeros(60,60);
for i=1:60
    X2d(i,:)=binX(((60*i)-59):(60*i));
end
%X2d=X2d';
seq=zeros(1,60);

count=1;
for i=1:60
    for j=1:60
        if X2d(i,j) == 1
            seq(j)=i;
            count=count+1;
        end
    end
end
