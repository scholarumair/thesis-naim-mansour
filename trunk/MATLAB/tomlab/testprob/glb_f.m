% function f = glb_f(x, Prob)
%
% Test functions for global optimization.

% Kenneth Holmstrom, Tomlab Optimization Inc., E-mail: tomlab@tomopt.com.
% Copyright (c) 1999-2008 by Tomlab Optimization Inc. $Release: 6.2.0$
% Written June 1, 1999.   Last modified Jun 3, 2008.

function f = glb_f(x, Prob)

x=x(:);

P=Prob.P;
uP=Prob.uP;

if P == 1 % Shekel 5
    A = [4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7];
    c = [.1 .2 .2 .4 .4]';
    f=0;
    for i = 1:5
        f = f - 1./( (x-A(i,:)' )'*( x-A(i,:)' ) + c(i) );
    end
elseif P == 2 % Shekel 7
    A = [4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3];
    c = [.1 .2 .2 .4 .4 .6 .3]';
    f=0;
    for i = 1:7
        f = f - 1./( (x-A(i,:)' )'*( x-A(i,:)' ) + c(i) );
    end
elseif P == 3 % Shekel 10
    A = [4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;...
        8 1 8 1;6 2 6 2;7 3.6 7 3.6];
    c = [.1 .2 .2 .4 .4 .6 .3 .7 .5 .5]';
    f=0;
    for i = 1:10
        f = f - 1./( (x-A(i,:)' )'*( x-A(i,:)' ) + c(i) );
    end
elseif P == 4 % Hartman 3
    A=[3 10 30;.1 10 35;3 10 30;.1 10 35];
    p=[.3689 .1170 .2673;.4699 .4387 .7470;...
        .1091 .8732 .5547;.03815 .5743 .8828];
    c=[1 1.2 3 3.2]';
    f=0;
    for i=1:4
        e1 = exp(-sum( A(i,:)'.*(x-p(i,:)').^2 ) );
        f = f - c(i)*e1;
    end
elseif P == 5 % Hartman 6
    A=[10 3 17 3.5 1.7 8;.05 10 17 .1 8 14;...
        3 3.5 1.7 10 17 8;17 8 .05 10 .1 14];
    p=[.1312 .1696 .5569 .0124 .8283 .5886
        .2329 .4135 .8307 .3736 .1004 .9991
        .2348 .1451 .3522 .2883 .3047 .6650
        .4047 .8828 .8732 .5743 .1091 .0381];
    c=[1 1.2 3 3.2]';
    f=0;
    for i=1:4
        e1 = exp(-sum( A(i,:)'.*(x-p(i,:)').^2 ) );
        f = f - c(i)*e1;
    end
elseif P == 6 % Branin RCOS
    f = (x(2)-5.1*x(1)^2/(4*pi^2) + 5*x(1)/pi -6)^2 +...
        10*(1-1/(8*pi))*cos(x(1)) + 10;
elseif P == 7 % Goldstein and Price
    f = ( 1+(x(1)+x(2)+1)^2*(19-14*x(1)+3*x(1)^2-14*x(2)+6*x(1)*x(2)+...
        3*x(2)^2) ) * ( 30+(2*x(1)-3*x(2))^2*(18-32*x(1)+12*x(1)^2+...
        48*x(2)-36*x(1)*x(2)+27*x(2)^2) );
elseif P == 8 % Six-Hump Camel
    f = (4-2.1*x(1)^2+x(1)^4/3)*x(1)^2+x(1)*x(2)+(-4+4*x(2)^2)*x(2)^2;
elseif P == 9 % Two-Dimensional Shubert
    tmp = [1 2 3 4 5]';
    sum1 = sum( tmp.*cos( (tmp+1).*x(1)+tmp) );
    sum2 = sum( tmp.*cos( (tmp+1).*x(2)+tmp) );
    f = sum1 * sum2 ;
elseif P == 10 | P == 11 | P == 12 % Sphere model 2/5/10
    f=(x-1)'*(x-1);
elseif P == 13 | P == 14 | P == 15 % Griewanks function 2/5/10
    d=4000;
    prodd=1;
    for i=1:size(x,1)
        prodd=prodd*cos((x(i)-100)/sqrt(i));
    end;
    f=(x-100)'*(x-100)/d-prodd+1;
elseif P == 16 | P == 17 | P == 18 % Shekels foxholes 2/5/10
    [A,c] =iceo3d;
    dim   = size(x,1);
    m     = size(c,1);
    sqn   = zeros(m,1);
    for i=1:m,
        sqn(i)=(x-A(1:dim,i))'*(x-A(1:dim,i));
    end;
    f = -sum(1./(sqn+c));
elseif P == 19 | P == 20 | P == 21 % Michalewiczs function 5/10
    m = 10;
    zweim = 2*m;
    fac = zeros(size(x,1),1);
    for i=1:size(x,1)
        fac(i)=sin(i*x(i)^2/pi);
    end;
    f = -sin(x)'*(fac.^zweim);
elseif P == 22 | P == 23 | P == 24 % Langermans function 5/10
    [A,c] = iceo5d;
    dim = size(x,1);
    m = size(c,1);
    sqn = zeros(m,1);
    for i=1:m
        sqn(i)=(x-A(1:dim,i))'*(x-A(1:dim,i));
    end;
    f = -c'*(exp(-sqn/pi).*cos(sqn*pi));
elseif P == 25 % HGO 468:1
    f = 4*x(1)*x(2)*sin(4*pi*x(2));
    f=-f;
elseif P == 26 % HGO 468:2
    f = sin(2*x(1)+1) + 2*sin(3*x(2)+2);
    f=-f;
elseif P == 27 % Hock-Schittkowski 5
    f = sin(x(1)+x(2))+(x(1)-x(2))^2-1.5*x(1)+2.5*x(2)+1;
elseif P == 28 % Rosenbrock banana
    f = 1 + 100*(x(2)-x(1)^2)^2 + (1-x(1))^2;
elseif P == 29 % Myers smooth
    a = 0.5; b = 2;
    f = 2+4*x(1)+4*x(2) - x(1)^2 -x(2)^2 + a*sin(b*x(1))*sin(b*x(2));
elseif P == 30 % Myers smoothly fluctuating
    a = 2; b = 2;
    f = 2+4*x(1)+4*x(2) - x(1)^2 -x(2)^2 + a*sin(b*x(1))*sin(b*x(2));
elseif P == 31 % Myers strongly fluctuating
    a = 0.5; b = 10;
    f = 2+4*x(1)+4*x(2) - x(1)^2 -x(2)^2 + a*sin(b*x(1))*sin(b*x(2));
elseif P == 32 % LOG-Goldstein and Price
    f = ( 1+(x(1)+x(2)+1)^2*(19-14*x(1)+3*x(1)^2-14*x(2)+6*x(1)*x(2)+...
        3*x(2)^2) ) * ( 30+(2*x(1)-3*x(2))^2*(18-32*x(1)+12*x(1)^2+...
        48*x(2)-36*x(1)*x(2)+27*x(2)^2) );
    f = log(f);
elseif P == 33 % Easom (ES) 2
    x1 = x(1); x2 = x(2);
    f = -cos(x1).*cos(x2).*exp(-((x1-pi).^2+(x2-pi).^2));
elseif P == 34 % De Joung (DJ) 3
    f = sum(x.^2);
elseif P == 35 | P == 36 | P == 37 | P == 38 | P == 39 % Rosenbrock 5, 10, 20, 50, 100
    f=0;
    for j = 1:Prob.N-1
        f = f + 100*(x(j,:).^2-x(j+1,:)).^2 + (x(j,:)-1).^2;
    end
elseif P == 40 | P == 41 | P == 42 | P == 43 | P == 44 | P == 45 % Zakharov 2, 5, 10, 20, 50, 100
    f1 = 0;
    f2 = 0;
    for j = 1:Prob.N
        f1 = f1 + x(j,:).^2;
        f2 = f2 + 0.5*j*x(j,:);
    end
    f = f1 + f2.^2 + f2.^4;
elseif P == 46 % Bohachevsky 1 (B1) 2
    x1 = x(1); x2 = x(2);
    f = x1.^2 + 2*x2.^2 - 0.3*cos(3*pi*x1) - 0.4*cos(4*pi*x2) + 0.7;
elseif P == 47 % Bohachevsky 2 (B2) 2
    x1 = x(1); x2 = x(2);
    f = x1.^2 + 2*x2.^2 - 0.3*cos(3*pi*x1).*cos(4*pi*x2) + 0.3;
elseif P == 48 % Bohachevsky 3 (B3) 2
    x1 = x(1); x2 = x(2);
    f = x1.^2 + 2*x2.^2 - 0.3*cos(3*pi*x1 + 4*pi*x2) + 0.3;
elseif P == 49 % Griewank (GR) 6
    C = 1;
    f = sum(x,1)/4000 - prod(cos(x./((1:6)'*ones(1,C)).^0.5), 1) + 1;
elseif P == 50 % Aaron 1 2
    x1 = x(1); x2 = x(2);
    f = (x1.*sin(20*x2)+x2.*sin(20*x1)).^2.*cosh(sin(10*x1).*x1) ...
        +(x1.*cos(10*x2)-x2.*sin(10*x1)).^2.*cosh(cos(20*x2).*x2);
elseif P == 51 % Aaron 2 2
    x1 = x(1); x2 = x(2);
    f = -(x1.*sin(20*x2)+x2.*sin(20*x1)).^2.*cosh(sin(10*x1).*x1) ...
        -(x1.*cos(10*x2)-x2.*sin(10*x1)).^2.*cosh(cos(20*x2).*x2);
elseif P == 52 % Booth
    x1 = x(1); x2 = x(2);
    f = (x1+2*x2-7)^2+(2*x1+x2-5)^2;
elseif P == 53 % Dixon & Price
   % P.N == 7
   %f=(x(1)-1)^2+2*(2*x(2)^2-x(1))^2+3*(2*x(3)^2-x(2))^2+4*(2*x(4)^2-x(3))^2+...
   %  5*(2*x(5)^2-x(4))^2+6*(2*x(6)^2-x(5))^2+7*(2*x(7)^2-x(6))^2;
    m = Prob.N;
    f=(x(1)-1)^2;
    for i=2:m
        f = f + i*(2*x(i)^2-x(i-1))^2;
    end

elseif P == 54 % Spiral
    r = norm(x);
    if r==0, r=1E-10; end
    if x(2) >= 0
        phi = acos(x(1)/r);
    else
        phi = 2*pi - acos(x(1)/r);
    end
    f = uP(1)*sin(phi + r) + uP(2)*r;
elseif P == 55 % EXP-Shekel 5
    A = [4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7];
    c = [.1 .2 .2 .4 .4]';
    f=0;
    for i = 1:5
        f = f - 1./( (x-A(i,:)' )'*( x-A(i,:)' ) + c(i) );
    end
    f = 1E5*exp(f);
end

% function [A,c]=iceo3d
% data for iceo test case 3 (Shekel's foxholes)
function [A,c]=iceo3d

A=[...
    9.681, 0.667, 4.783, 9.095, 3.517, 9.325, 6.544, 0.211, 5.122, 2.020;...
    9.400, 2.041, 3.788, 7.931, 2.882, 2.672, 3.568, 1.284, 7.033, 7.374;...
    8.025, 9.152, 5.114, 7.621, 4.564, 4.711, 2.996, 6.126, 0.734, 4.982;...
    2.196, 0.415, 5.649, 6.979, 9.510, 9.166, 6.304, 6.054, 9.377, 1.426;...
    8.074, 8.777, 3.467, 1.863, 6.708, 6.349, 4.534, 0.276, 7.633, 1.567;...
    7.650, 5.658, 0.720, 2.764, 3.278, 5.283, 7.474, 6.274, 1.409, 8.208;...
    1.256, 3.605, 8.623, 6.905, 0.584, 8.133, 6.071, 6.888, 4.187, 5.448;...
    8.314, 2.261, 4.224, 1.781, 4.124, 0.932, 8.129, 8.658, 1.208, 5.762;...
    0.226, 8.858, 1.420, 0.945, 1.622, 4.698, 6.228, 9.096, 0.972, 7.637;...
    7.305, 2.228, 1.242, 5.928, 9.133, 1.826, 4.060, 5.204, 8.713, 8.247;...
    0.652, 7.027, 0.508, 4.876, 8.807, 4.632, 5.808, 6.937, 3.291, 7.016;...
    2.699, 3.516, 5.874, 4.119, 4.461, 7.496, 8.817, 0.690, 6.593, 9.789;...
    8.327, 3.897, 2.017, 9.570, 9.825, 1.150, 1.395, 3.885, 6.354, 0.109;...
    2.132, 7.006, 7.136, 2.641, 1.882, 5.943, 7.273, 7.691, 2.880, 0.564;...
    4.707, 5.579, 4.080, 0.581, 9.698, 8.542, 8.077, 8.515, 9.231, 4.670;...
    8.304, 7.559, 8.567, 0.322, 7.128, 8.392, 1.472, 8.524, 2.277, 7.826;...
    8.632, 4.409, 4.832, 5.768, 7.050, 6.715, 1.711, 4.323, 4.405, 4.591;...
    4.887, 9.112, 0.170, 8.967, 9.693, 9.867, 7.508, 7.770, 8.382, 6.740;...
    2.440, 6.686, 4.299, 1.007, 7.008, 1.427, 9.398, 8.480, 9.950, 1.675;...
    6.306, 8.583, 6.084, 1.138, 4.350, 3.134, 7.853, 6.061, 7.457, 2.258;...
    0.652, 2.343, 1.370, 0.821, 1.310, 1.063, 0.689, 8.819, 8.833, 9.070;...
    5.558, 1.272, 5.756, 9.857, 2.279, 2.764, 1.284, 1.677, 1.244, 1.234;...
    3.352, 7.549, 9.817, 9.437, 8.687, 4.167, 2.570, 6.540, 0.228, 0.027;...
    8.798, 0.880, 2.370, 0.168, 1.701, 3.680, 1.231, 2.390, 2.499, 0.064;...
    1.460, 8.057, 1.336, 7.217, 7.914, 3.615, 9.981, 9.198, 5.292, 1.224;...
    0.432, 8.645, 8.774, 0.249, 8.081, 7.461, 4.416, 0.652, 4.002, 4.644;...
    0.679, 2.800, 5.523, 3.049, 2.968, 7.225, 6.730, 4.199, 9.614, 9.229;...
    4.263, 1.074, 7.286, 5.599, 8.291, 5.200, 9.214, 8.272, 4.398, 4.506;...
    9.496, 4.830, 3.150, 8.270, 5.079, 1.231, 5.731, 9.494, 1.883, 9.732;...
    4.138, 2.562, 2.532, 9.661, 5.611, 5.500, 6.886, 2.341, 9.699, 6.500;...
    ]';
c= [0.806,0.517,0.100,0.908,0.965,0.669,0.524,0.902,0.531,0.876,...
    0.462,0.491,0.463,0.714,0.352,0.869,0.813,0.811,0.828,0.964,...
    0.789,0.360,0.369,0.992,0.332,0.817,0.632,0.883,0.608,0.326]';

% function [A,c]=iceo5d
% data for iceo test case 5 (Langerman's function)
function [A,c]=iceo5d

A=[...
    9.681, 0.667, 4.783, 9.095, 3.517, 9.325, 6.544, 0.211, 5.122, 2.020;...
    9.400, 2.041, 3.788, 7.931, 2.882, 2.672, 3.568, 1.284, 7.033, 7.374;...
    8.025, 9.152, 5.114, 7.621, 4.564, 4.711, 2.996, 6.126, 0.734, 4.982;...
    2.196, 0.415, 5.649, 6.979, 9.510, 9.166, 6.304, 6.054, 9.377, 1.426;...
    8.074, 8.777, 3.467, 1.863, 6.708, 6.349, 4.534, 0.276, 7.633, 1.567;...
    7.650, 5.658, 0.720, 2.764, 3.278, 5.283, 7.474, 6.274, 1.409, 8.208;...
    1.256, 3.605, 8.623, 6.905, 0.584, 8.133, 6.071, 6.888, 4.187, 5.448;...
    8.314, 2.261, 4.224, 1.781, 4.124, 0.932, 8.129, 8.658, 1.208, 5.762;...
    0.226, 8.858, 1.420, 0.945, 1.622, 4.698, 6.228, 9.096, 0.972, 7.637;...
    7.305, 2.228, 1.242, 5.928, 9.133, 1.826, 4.060, 5.204, 8.713, 8.247;...
    0.652, 7.027, 0.508, 4.876, 8.807, 4.632, 5.808, 6.937, 3.291, 7.016;...
    2.699, 3.516, 5.874, 4.119, 4.461, 7.496, 8.817, 0.690, 6.593, 9.789;...
    8.327, 3.897, 2.017, 9.570, 9.825, 1.150, 1.395, 3.885, 6.354, 0.109;...
    2.132, 7.006, 7.136, 2.641, 1.882, 5.943, 7.273, 7.691, 2.880, 0.564;...
    4.707, 5.579, 4.080, 0.581, 9.698, 8.542, 8.077, 8.515, 9.231, 4.670;...
    8.304, 7.559, 8.567, 0.322, 7.128, 8.392, 1.472, 8.524, 2.277, 7.826;...
    8.632, 4.409, 4.832, 5.768, 7.050, 6.715, 1.711, 4.323, 4.405, 4.591;...
    4.887, 9.112, 0.170, 8.967, 9.693, 9.867, 7.508, 7.770, 8.382, 6.740;...
    2.440, 6.686, 4.299, 1.007, 7.008, 1.427, 9.398, 8.480, 9.950, 1.675;...
    6.306, 8.583, 6.084, 1.138, 4.350, 3.134, 7.853, 6.061, 7.457, 2.258;...
    0.652, 2.343, 1.370, 0.821, 1.310, 1.063, 0.689, 8.819, 8.833, 9.070;...
    5.558, 1.272, 5.756, 9.857, 2.279, 2.764, 1.284, 1.677, 1.244, 1.234;...
    3.352, 7.549, 9.817, 9.437, 8.687, 4.167, 2.570, 6.540, 0.228, 0.027;...
    8.798, 0.880, 2.370, 0.168, 1.701, 3.680, 1.231, 2.390, 2.499, 0.064;...
    1.460, 8.057, 1.336, 7.217, 7.914, 3.615, 9.981, 9.198, 5.292, 1.224;...
    0.432, 8.645, 8.774, 0.249, 8.081, 7.461, 4.416, 0.652, 4.002, 4.644;...
    0.679, 2.800, 5.523, 3.049, 2.968, 7.225, 6.730, 4.199, 9.614, 9.229;...
    4.263, 1.074, 7.286, 5.599, 8.291, 5.200, 9.214, 8.272, 4.398, 4.506;...
    9.496, 4.830, 3.150, 8.270, 5.079, 1.231, 5.731, 9.494, 1.883, 9.732;...
    4.138, 2.562, 2.532, 9.661, 5.611, 5.500, 6.886, 2.341, 9.699, 6.500;...
    ]';
c=[0.806,0.517,1.500,0.908,0.965,0.669,0.524,0.902,0.531,0.876,...
    0.462,0.491,0.463,0.714,0.352,0.869,0.813,0.811,0.828,0.964,...
    0.789,0.360,0.369,0.992,0.332,0.817,0.632,0.883,0.608,0.326]';

% MODIFICATION LOG
%
% 990413  mbk  Added problem Hock-Schittkowski 5
% 050405  med  Added 19 problems
% 061127  hkh  Error in #6 Branin, factor 5 should be 5.1
% 080603  med  Switched to glcAssign, cleaned