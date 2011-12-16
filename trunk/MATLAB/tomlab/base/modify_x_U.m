% function Prob = modify_x_U(Prob, x_U, idx)
%
% PURPOSE:    Modify upper bounds for decision variables. If idx is not
%             given x_U will be replaced. x_0 will be shifted if needed.
%
% INPUTS:
%
% Prob        Existing TOMLAB problem
% x_U         New upper bounds for the decision variables
% idx         Indices for the modified upper bounds (optional)
%
% OUTPUTS:
%
% Prob        Modified TOMLAB problem

% Marcus Edvall, Tomlab Optimization Inc, E-mail: tomlab@tomopt.com
% Copyright (c) 2006-2006 by Tomlab Optimization Inc., $Release: 5.5.0$
% Written Aug 15, 2006.   Last modified Aug 15, 2006.

function Prob = modify_x_U(Prob, x_U, idx)

if nargin < 2
    error('modify_x_U requires at least 2 inputs');
end

if nargin == 3
    if length(idx) ~= length(x_U)
        error('Length of idx does not match length of x_U');
    end
    if max(idx) > Prob.N
        error('Indices exceed number of variables');
    end
    if min(idx) < 1
        error('Values in idx are lower than 1');
    end
end

if nargin == 2
    if length(x_U) ~= Prob.N
        error('Length of x_U does not match current length of x_U');
    end
    Prob.x_U = full(double(x_U(:)));
else
    Prob.x_U(idx) = double(x_U(:));
end

if isempty(Prob.x_L)
    Prob.x_L = -inf*ones(Prob.N,1);
end

if any(Prob.x_L>Prob.x_U)
    error('x_L and x_U have crossover values');
end

if isempty(Prob.x_0)
    Prob.x_0=zeros(Prob.N,1);
end
Prob.x_0 = max(Prob.x_L,min(Prob.x_U,Prob.x_0));

% MODIFICATION LOG
%
% 060814  med  Written