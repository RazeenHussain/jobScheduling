function [P,W,D,S] = extractData(dataFile)
    fileID = fopen(dataFile);
    data = textscan(fileID,'%s');
    fclose(fileID);
    P = data{1}(38 : 1 : 97);
    W = data{1}(99 : 1 : 158);
    D = data{1}(160 : 1 : 219);
    dummy = data{1}(224 : 3 : 11021);
    k=1;
    for i=1:61
        for j=1:60
            if i == (j+1)
                S(i,j)={'0'};
            else
                S(i,j)=dummy(k);
                k=k+1;
            end
        end
    end
    P=str2double(P);
    W=str2double(W);
    W=W';
    D=str2double(D);
    S=str2double(S);
end