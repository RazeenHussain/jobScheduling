function [R] = jobRemoval(sequence,removed)
indexes=zeros(4,1);
for j=1:4
    indexes(j)=find(sequence==removed(j));
    sequence(indexes(j))=0;
end
R=(sequence(find(sequence)));