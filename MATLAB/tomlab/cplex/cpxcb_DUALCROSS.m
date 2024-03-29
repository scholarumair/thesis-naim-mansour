% function ret = cpxcb_DUALCROSS(cpxCBInfo)
%
% CPLEX Dual crossover callback
%
% Called from TOMLAB /CPLEX during the dual crossover algorithm.
%
% This callback is enabled by setting callback(4)=1 in the call to
% cplex.m, or Prob.MIP.callback(4)=1 if using tomRun('cplex',...)
%
% cpxcb_DUALCROSS is called with one argument, the cpxCBInfo progress
% information vector.
%
% Contents of cpxCBInfo vector:
%
%  i  cpxCBInfo(i)    - Value
%  -------------------------------------------------------------
%  1  PRIMAL_OBJ      - primal objective value               
%  2  DUAL_OBJ        - dual objective value  		      
%  3  PRIMAL_INFMEAS  - measure of primal infeasibility      
%  4  DUAL_INFMEAS    - measure of dual infeasibility 	      
%  5  PRIMAL_FEAS     - 1 if primal feasible, 0 if not       
%  6  DUAL_FEAS       - 1 if dual feasible, 0 if not  	      
%  7  ITCOUNT         - iteration count 		      
%  8  CROSSOVER_PPUSH - primal push crossover itn. count     
%  9  CROSSOVER_PEXCH - primal exchange crossover itn. count 
% 10  CROSSOVER_DPUSH - dual push crossover itn. count       
% 11  CROSSOVER_DEXCH - dual exchange crossover itn. count   
%
% By returning a nonzero value from cpxcb_DUALCROSS, the user can
% terminate the optimization.
%
% If modifying this file, it is recommended to make a copy of it which
% is placed before the original file in the MATLAB path.
%

% Kenneth Holmstrom, Tomlab Optimization Inc., E-mail: tomlab@tomopt.com
% Copyright (c) 2002-2007 by Tomlab Optimization Inc., $Release: 11.0.0$
% Written Sept 22, 2002   Last modified Feb 2, 2006

function ret = cpxcb_DUALCROSS(cpxCBInfo)

%% INSERT USER CODE HERE. 
%
% To terminate optimization, return a nonzero value in 'ret'.

ret = 0;
