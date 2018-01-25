function [newSeq]=inversion(i,j,oldSeq)
    newSeq=oldSeq;
    temp=fliplr(oldSeq(i:j));
    newSeq(i:j)=temp;
end   