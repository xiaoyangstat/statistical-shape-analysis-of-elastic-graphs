function [q2new,R] = Find_Best_Rotation(q1,q2,identity)
% Assumes the starting points are fixed

[d,~] = size(q1);

if nargin==3
    R = eye(d);
    q2new = R*q2;
    return
end

A = q1*q2';
[U,~,V] = svd(A);

if det(A) > 0
    S = eye(d);
else
    S = eye(d);
    S(:,end) = -S(:,end);
end

R = U*S*V;
q2new = R*q2;