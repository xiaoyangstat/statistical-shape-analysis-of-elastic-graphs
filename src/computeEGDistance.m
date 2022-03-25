function d = computeEGDistance(EG1,EG2,scale)
% Compute the edge distance in graph space, (optional) scaled by overal length
%
% Args:
%   EG1, EG2:
%   scale: whether to scale the elastic graphs by their total edge lengths 

if nargin<3
    scale = true;
end

A1 = EG1.A; A2 = EG2.A;
Abeta1 = EG1.Abeta;Abeta2 = EG2.Abeta;
Abetaq1 = zeros(size(Abeta1));
Abetaq2 = zeros(size(Abeta2));

n = size(Abeta1,3);
l1 = 0;l2 = 0;
for i = 1:n
    for j = i+1:n
      if A1(i,j)||A2(i,j)
        q = curve_to_q(Abeta1(:,:,i,j),false);
        l1 = l1 + sqrt(InnerProd_Q(q,q));
        Abetaq1(:,:,i,j) = q;
        q = curve_to_q(Abeta2(:,:,i,j),false);
        l2 = l2 + sqrt(InnerProd_Q(q,q));
        Abetaq2(:,:,i,j) = q;
      end
    end
end

if ~scale
    l1 = 1;
    l2 = 1;
end

d = 0;
for i = 1:n
    for j = i+1:n
      if A1(i,j)||A2(i,j)
        q1 = Abetaq1(:,:,i,j)/l1;
        q2 = Abetaq2(:,:,i,j)/l2;
        d = d + norm(q1-q2)^2;
      end
    end
end

d = sqrt(d);

end
