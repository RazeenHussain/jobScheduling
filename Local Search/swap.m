function [newSeq] = swap(i,j,oldSeq)
    newSeq=oldSeq;
    newSeq(i)=oldSeq(j);
    newSeq(j)=oldSeq(i);
end