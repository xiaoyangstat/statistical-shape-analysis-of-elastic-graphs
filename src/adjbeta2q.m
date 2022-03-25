function [Abetaq,l] = adjbeta2q(Abeta,A,rescale)
% Convert adjacency beta matrix into adjacency q matrix

% Returns:
%   l: overall length of EG

if nargin<3
    rescale = false;
end

Abetaq = zeros(size(Abeta));
n = size(A,1);
l = 0;
for i = 1:n
    for j = 1:n
        if A(i,j)
            q = curve_to_q(Abeta(:,:,i,j),rescale);
            l = l + sqrt(InnerProd_Q(q,q));
            Abetaq(:,:,i,j) = q;
        end
    end
end

l = l/2;

end