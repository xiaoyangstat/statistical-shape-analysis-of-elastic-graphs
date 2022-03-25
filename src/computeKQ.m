function KQ = computeKQ(beta1,beta2)
% KQ is the edge similarity matrix. Large value means more similarity
% Here is the SRVF inner product between two shapes

r = size(beta1,3);c = size(beta2,3);

KQ = zeros(2*r,2*c); % times 2 means directed graph

for i = 1:r
    for j = 1:c
        q1 = curve_to_q(beta1(:,:,i));
        q2 = curve_to_q(beta2(:,:,j));
        [tmp,~] = ElasticShootingVector(q1,q2);
        KQ(i,j) = tmp;
    end
end

% bottom right
for i = r+1:2*r
    for j = c+1:2*c
        KQ(i,j) = KQ(i-r,j-c);
    end
end

% top right, flip q2
c1 = c+1;c2 = 2*c;
for i = 1:r
    for j = c1:c2
        q1 = curve_to_q(beta1(:,:,i));
        q2 = curve_to_q(fliplr(beta2(:,:,j-c)));
        [tmp,~] = ElasticShootingVector(q1,q2);
        KQ(i,j) = tmp;
    end
end

% bottom left, flip q1
for i = r+1:2*r
    for j = 1:c
        KQ(i,j) = KQ(i-r,j+c);
    end
end

minKQ = min(KQ(:));
if minKQ<0
    %fprintf('the minimum of KQ is negative: %d\n',minKQ);
    KQ = KQ + 2*abs(minKQ);
end

stat = [quantile(KQ(:),0.01) quantile(KQ(:),0.25) quantile(KQ(:),0.5) quantile(KQ(:),0.75) quantile(KQ(:),0.99)];
fprintf('edge affinity 5 number summary: %.2f %.2f %.2f %.2f %.2f\n', stat');
