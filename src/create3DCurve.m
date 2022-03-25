function beta = create3DCurve(node1,node2,sig,T,seed)
if nargin>4
    rng(seed);
end

t = linspace(0,1,T);

%% option: linear
% n = 15;
% x = linspace(node1(1),node2(1),n);
% y = linspace(node1(2),node2(2),n);
% z = linspace(node1(3),node2(3),n);
% 
% 
% for i = 1:5:n
%     x(i) = x(i) + normrnd(0,sig);
%     y(i) = y(i) + normrnd(0,sig);
%     z(i) = z(i) + normrnd(0,sig);
% end
% 
% 
% beta(1,:) = interp1(linspace(0,1,n),x,t,'spline');
% beta(2,:) = interp1(linspace(0,1,n),y,t,'spline');
% beta(3,:) = interp1(linspace(0,1,n),z,t,'spline');

%% option: cubic function
beta(1,:) = t;
beta(2,:) = 0.5*sin(rand*4*pi*t+pi/2*rand);
beta(3,:) = 0.5*cos(rand*4*pi*t+pi/2*rand);

beta = shape2curve(beta,node1,node2);
