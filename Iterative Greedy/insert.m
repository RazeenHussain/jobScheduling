function [new]=insert(pos,job,old)
if (pos==1)
    new=[job,old];
elseif (pos==(length(old)+1))
    new=[old,job];
else
    new=[old(1:(pos-1)),job,old(pos:(length(old)))];
end