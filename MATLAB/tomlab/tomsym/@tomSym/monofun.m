function y = monofun(info,x)
% monofun - Overloaded function

% Per Rutquist, Tomlab Optimization Inc, E-mail: tomlab@tomopt.com
% Copyright (c) 2008-2009 by Tomlab Optimization Inc.
% Last modified 2009-12-23 by rutquist for TOMLAB release 7.7

y = tomSym(mfilename,size(x,1),size(x,2),info,x);
