function [q] = curve_to_q(p,scale)

if nargin<2
    scale=false;
end

[d,T] = size(p);
for i = 1:d
    v(i,:) = gradient(p(i,:),1/(T-1));
end

for i = 1:T
    L(i) = sqrt(norm(v(:,i),'fro'));
    if L(i) > 0.000001
        q(:,i) = v(:,i)/L(i);
    else
        q(:,i) = 0*ones(d,1);
    end
end

if scale==true
    q = q/(sqrt(InnerProd_Q(q,q))+eps);
end