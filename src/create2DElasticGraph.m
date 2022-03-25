function EG = create2DElasticGraph(n,p,T,sig)
% simulate a elastic graph while edges are shapes
% 
% Args:
%   n: # of nodes
%   p: # probability of edges
%   T: # of points for each edge
%   sig: noise level, see `create2Dcurve`

%% adjacency matrix
A = createBinomialGraph(n,p);
Gph = graph(A);

%% node coordinate
figure;
h = plot(Gph);
nodeX = h.XData;
nodeY = h.YData;
nodeXY = [nodeX;nodeY];
close

%% edges
Abeta = zeros(2,T,n,n);
for i = 1:n
    for j = i+1:n
        if A(i,j)
            Abeta(:,:,i,j) = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);%max(max(nodeXY))
            Abeta(:,:,j,i) = fliplr(Abeta(:,:,i,j));
        end
    end
end

[G,H,~] = adj2GH(A);

EG = struct('Abeta',Abeta,'beta',adj2beta(Abeta,A),'nodeXY',nodeXY,'A',A,'G',G,'H',H);