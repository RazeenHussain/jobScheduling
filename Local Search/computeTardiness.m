function [T] = computeTardiness(C,D)
    T=C-D;
    T(T<0)=0;
end