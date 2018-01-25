close all;
clc;
clear all;

try
    clear model;
    
    model = gurobi_read('model60.lp');

    clear params;
    params.outputflag = 1;
    params.logfile='log60_1hr.txt';
    params.timelimit=3600;

    result = gurobi(model, params);

catch gurobiError
    fprintf('Error reported\n');
end

save('result60_1hr','result');