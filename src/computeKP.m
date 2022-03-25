function KP = computeKP(nodeXY1,nodeXY2,sigma)
% KP is the node similarity matrix.
% Here is the radial kernel

if nargin<3
    sigma=1;
end

r = size(nodeXY1,2);
c = size(nodeXY2,2);

KP = zeros(r,c);

for i = 1:r
    for j = 1:c
        KP(i,j) = exp(-norm(nodeXY1(:,i)-nodeXY2(:,j))/sigma);
    end
end

stat = [quantile(KP(:),0.01) quantile(KP(:),0.25) quantile(KP(:),0.5) quantile(KP(:),0.75) quantile(KP(:),0.99)];
fprintf('node affinity 5 number summary: %.2f %.2f %.2f %.2f %.2f\n', stat');
