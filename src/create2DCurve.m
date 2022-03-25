function beta = create2DCurve(node1,node2,T,sig,seed)
% create a random 2D curve
%
% Args:
%   T: number of points for each edge
%   sig: noise level, not used in option 3

if nargin>4
    rng(seed);
end

t = linspace(0,1,T);

%% option 1: line + normal noise
% n = 15;
% x = linspace(node1(1),node2(1),n);
% y = linspace(node1(2),node2(2),n);
% 
% xd = abs(node1(1)-node2(1)); yd = abs(node1(2)-node2(2));
% for i = 2:5:n-1
%     x(i) = x(i) + normrnd(0,sig*yd);
%     y(i) = y(i) + normrnd(0,sig*xd);
% end

%% option 2: sine curve
% if xd < yd % vertical curve
%     for i = 2:n-1
%         y(i) = y(i);
%         x(i) = 0.01*yd*sin(2*pi*y(i)*sig/yd)+normrnd(0,0.05*yd);
%     end
% else
%     for i = 2:n-1
%         x(i) = x(i);
%         y(i) = 0.01*xd*sin(2*pi*x(i)*sig/xd)+normrnd(0,0.05*xd);
%     end
% end

%% return
% beta(1,:) = smooth(interp1(linspace(0,1,n),x,t,'spline'));
% beta(2,:) = smooth(interp1(linspace(0,1,n),y,t,'spline'));

%% option 3: cubic function
beta(1,:) = t;
% beta(2,:) = (t).^(4*rand+2);
beta(2,:) = 0.2*sin(rand*2*pi*t+pi/2*rand);

th = pi/2+(pi/2)*randn;
O = [cos(th) -sin(th); sin(th) cos(th)];
beta = O*beta;

beta = shape2curve(beta,node1,node2);

