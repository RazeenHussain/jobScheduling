function [R] = uniqueRandomNumbers(limit)
R=zeros(4,1);
R(1)=randi(limit,1);
while(R(2)==0 || R(2)==R(1))
    R(2)=randi(limit,1);
end
while(R(3)==0 || R(3)==R(1) || R(3)==R(2))
    R(3)=randi(limit,1);
end
while(R(4)==0 || R(4)==R(1) || R(4)==R(2) || R(4)==R(3))
    R(4)=randi(limit,1);
end