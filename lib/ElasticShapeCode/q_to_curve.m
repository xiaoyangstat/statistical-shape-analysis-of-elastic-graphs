function p = q_to_curve(q)

[d,T] = size(q);

for i = 1:T
    qnorm(i) = norm(q(:,i),'fro');
end

for i = 1:d
    p(i,:) = [cumtrapz( q(i,:).*qnorm )/(T-1)] ;
end

% p(:,end) = p(:,1);
return;