close all;
clc;
clear all;

load('modelParam120');

try
    clear model;
    model.A = sparse(varA);
    model.obj = varObj;
    model.rhs = varRHS;
    model.sense = varSense;
    model.vtype = varType;
    model.modelsense = 'min';
    model.varnames = varName;

    gurobi_write(model, 'model120.lp');

catch gurobiError
    fprintf('Error reported\n');
end