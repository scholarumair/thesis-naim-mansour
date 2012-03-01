function y = triu(x,k)
% tomSym/triu - Overloaded function 

% Per Rutquist, Tomlab Optimization Inc, E-mail: tomlab@tomopt.com
% Copyright (c) 2008-2009 by Tomlab Optimization Inc.
% Last modified 2009-08-21 by rutquist for TOMLAB release 7.7

if nargin<2
    k = 0;
end

if ~isnumeric(k)
    error('tomSym/triu is only implemented for numeric k');
end

y = triu(ones(size(x)),k).*x;