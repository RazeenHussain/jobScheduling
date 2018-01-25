close all;
clear all;
clc;
[P W D S]=extractData('wt_sds_1.instance');
fileID = fopen('data_1.in','w');
for i=1:60
    fprintf(fileID,'%d\n',P(i));
end
for i=1:60
    fprintf(fileID,'%d\n',W(i));
end
for i=1:60
    fprintf(fileID,'%d\n',D(i));
end
for i=1:61
    for j=1:60
        fprintf(fileID,'%d\n',S(i,j));
    end
end
fclose(fileID);