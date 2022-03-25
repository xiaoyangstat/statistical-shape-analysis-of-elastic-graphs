function beta = createHelix(node1,node2,m,T)
% create a helix between node1 and node 2
% @paramters:
%   m: number of bends
%   T: number of cycles

x = linspace(node1(1),node2(1),T);
y = linspace(node1(2),node2(2),T);
z = linspace(node1(3),node2(3),T);
beta0 = [x;y;z];

t = linspace(0,1,T);
rawShape = 0.02*[sin(2*pi*m*t);cos(2*pi*m*t);t];

offset = round(0.4*T);
beta1 = shape2curve(rawShape,beta0(:,offset),beta0(:,end-offset));
beta1 = [beta0(:,1:offset-1) beta1 beta0(:,end-offset+1:end)];

t1 = linspace(0,1,size(beta1,2));

beta(1,:) = interp1(t1,beta1(1,:),t,'spline');
beta(2,:) = interp1(t1,beta1(2,:),t,'spline');
beta(3,:) = interp1(t1,beta1(3,:),t,'spline');

gamma = generateRandomWarping(T);
beta(1,:) = smooth(interp1(t,beta(1,:),gamma,'spline'));
beta(2,:) = smooth(interp1(t,beta(2,:),gamma,'spline'));
beta(3,:) = smooth(interp1(t,beta(3,:),gamma,'spline'));
