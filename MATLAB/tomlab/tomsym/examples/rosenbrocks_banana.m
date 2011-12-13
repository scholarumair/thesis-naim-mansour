% rosenbrocks_banana - TomSym NLP demonstration

% Per Rutquist, Tomlab Optimization Inc, E-mail: tomlab@tomopt.com
% Copyright (c) 2008-2008 by Tomlab Optimization Inc.

toms x1 x2
a = 100;

% Objective function
f = a*(x2-x1^2)^2 + (1-x1)^2;

% Constraints
c   = -x1^2 - x2;
con = {-1000 <= c  <= 0
    -10 <= x1 <= 2
    -10 <= x2 <= 2};

% Initial conditions
x0 = {x1 == -1.2; x2 == 1};

% Compile and solve problem
options = struct;
options.name = 'Rosenbrocks banana';
solution = ezsolve(f,con,x0,options);

% Show autogenerated functions
options = struct;
options.name = 'Rosenbrocks banana';
Prob = sym2prob('nlp',f,con,x0,options);
disp(' ');
disp('Autogenerated functions:')
type(Prob.FUNCS.f);
type(Prob.FUNCS.g);
type(Prob.FUNCS.H);
type(Prob.FUNCS.c);
type(Prob.FUNCS.dc);
type(Prob.FUNCS.d2c);
tomCleanup(Prob)
clear Prob