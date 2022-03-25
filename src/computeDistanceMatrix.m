function D_sym = computeDistanceMatrix(EG)

n = length(EG);
D = zeros(n,n);

for i = 1:n
    fprintf('calculating for row %d out of %d \n',i,n);
    for j = i+1:n
        [EG1s, EG2s] = addOneWayNullNodes(EG(i),EG(j));
        KQ = computeKQ(EG1s.beta,EG2s.beta);
        % node affinity matrix
        KP = zeros(size(EG1s.A)); 
        KP(1:n1,1:n2) = computeKP(EG1s.nodeXY,EG2s.nodeXY,100);
        [p, ~] = fgmEG(EG1s,EG2s,KQ,100,KP);
        EG1p = permutateElasticGraphs(EG1s,p,EG2s);
        D(i,j) = computePairwiseDistance(EG1p,EG2s); 
    end
end

D_sym = D + D';
        