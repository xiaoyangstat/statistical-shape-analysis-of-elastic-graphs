function EG = create3DElasticGraph(n,p,m,T)
% simulate a elastic graph while edges are shapes
% 
% parameters:
%   n: number of nodes
%   p: probility of edges
%   m: max cycles in edges(helix)
%   T: # of time points in each edges

%% adjacency matrix
A = createBinomialGraph(n,p);
Gph = graph(A);

%% node coordinate
figure;
h = plot(Gph);
nodeX = h.XData;
nodeY = h.YData;
close
% u = rand;
% nodeZ = u*nodeX + (1-u)*nodeY;
nodeZ = ones(size(nodeX));
nodeXY = [nodeX;nodeY;nodeZ];

%% edges
Abeta = zeros(3,T,n,n);
for i = 1:n
    for j = i+1:n
        if A(i,j)
            mr = randi([1,m]);
            Abeta(:,:,i,j) = createHelix(nodeXY(:,i),nodeXY(:,j),mr,T);%max(max(nodeXY))
            Abeta(:,:,j,i) = fliplr(Abeta(:,:,i,j));
        end
    end
end

[G,H,~] = adj2GH(A);

EG = struct('Abeta',Abeta,'beta',adj2beta(Abeta,A),'nodeXY',nodeXY,'A',A,'G',G,'H',H);