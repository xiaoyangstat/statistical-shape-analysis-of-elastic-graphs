function EG1p = permutateElasticGraphs(EG1,p,EG2)

Abeta1p = EG1.Abeta(:,:,p,p);
A1p = EG1.A(p,p);
n = size(A1p,1);

if nargin>2
    fprintf('registering edges\n')
    A2 = EG2.A;
    Abeta2 = EG2.Abeta;
    for i = 1:n
        for j = i+1:n
            if A1p(i,j)>0 && A2(i,j)>0
                q1 = curve_to_q(Abeta1p(:,:,i,j));
                q2 = curve_to_q(Abeta2(:,:,i,j));
                Abeta1p(:,:,i,j) = q_to_curve(Find_Rotation_and_Seed_unique(q2,q1));
            end
        end
    end

end

%% permuate the nodes
nodeXY1 = zeros(size(EG1.nodeXY));
for i = 1:size(nodeXY1,2)
    nodeXY1(:,i) = EG1.nodeXY(:,p(i));
end

%% form a new EG object
[G,H,~] = adj2GH(A1p);
beta = adj2beta(Abeta1p,A1p);

EG1p = EG1;
EG1p.Abeta = Abeta1p;
EG1p.nodeXY = nodeXY1;
EG1p.A = A1p;
EG1p.beta = beta;
EG1p.G = G;
EG1p.H = H;
