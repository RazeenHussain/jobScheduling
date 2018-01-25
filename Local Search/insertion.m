function [newSeq]=insertion(i,j,oldSeq)
    newSeq=oldSeq;
    if (i<j)
        for l=i+1:j
            newSeq(l-1)=oldSeq(l);
        end
    else
        for l=j:i-1
            newSeq(l+1)=oldSeq(l);
        end
    end
    newSeq(j)=oldSeq(i);
end