include "globals.mzn";

int: nJobs = 60;

array[1..nJobs] of int: pTime;
array[1..nJobs] of int: weight;
array[1..nJobs] of int: dTime;
array[0..nJobs, 1..nJobs] of int: sTime;

array[1..nJobs] of var 1..nJobs: jobs;

array[1..nJobs] of var int: cTime;
array[1..nJobs] of var int: tardiness;

var int: cost;

solve minimize cost;

constraint 
  all_different(jobs) /\
  cTime[1]=pTime[jobs[1]]+sTime[0,jobs[1]] /\
  forall(j in 2..nJobs)(cTime[j] = pTime[jobs[j]]+cTime[j-1]+sTime[jobs[j-1],jobs[j]]) /\
  forall(k in 1..nJobs)(tardiness[k] = max(0,cTime[k]-dTime[jobs[k]])) /\
  cost = sum(n in jobs)(tardiness[n]*weight[jobs[n]])
;

output [
  "OBJECTIVE FUNCTION : ", show(cost), "\n",
  "SEQUENCE : ", show(jobs), "\n\n",
];