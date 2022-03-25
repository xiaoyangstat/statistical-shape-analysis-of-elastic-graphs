function muEG = avgEG(EG,rescale,interp)
% Average a sample of matched elastic graphs without template
%
% Args:
%   EG: array of matched Elastic Graph struct. They should be equal sized.
%   nmaxi: the index of template
%   rescale: true/false; whether rescale into unit length
%   interp: [] or not; whether interpolate mean shape between mean nodes

if nargin < 2
    rescale = false;
    interp = true;
end

%% averaging
n = length(EG);

nnode = size(EG(1).A,1);
d = size(EG(1).Abeta,1);
T = size(EG(1).Abeta,2);

muA = zeros(nnode,nnode); 
muAbetaq = zeros(d,T,nnode,nnode);
muNodeXY = zeros(d,nnode);

for i = 1:n
    muA = muA + EG(i).A;

    [tmp,l] = adjbeta2q(EG(i).Abeta,EG(i).A);
    if rescale
        tmp = tmp/l;
    end
    muAbetaq = muAbetaq + tmp;
    
    muNodeXY = muNodeXY + EG(i).nodeXY;
end
muA = muA/n;
muAbeta = adjq2beta(muAbetaq/n,muA);
muNodeXY = muNodeXY/n;

[G,H,~] = adj2GH(muA);

if ~isempty(interp)
    n_mu = size(muA,1);
    for i = 1:n_mu
        for j = i+1:n_mu
            if muA(i,j)
                muAbeta(:,:,i,j) = shape2curve(muAbeta(:,:,i,j),muNodeXY(:,i),muNodeXY(:,j));
            end
        end
    end

end

muEG = struct('beta',adj2beta(muAbeta,muA),'A',muA,'G',G,'H',H,'Abeta',muAbeta,'nodeXY',muNodeXY);

