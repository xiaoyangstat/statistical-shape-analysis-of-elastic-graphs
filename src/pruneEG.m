function EG_prune = pruneEG(EG,nodes1,keys,values)
% Delete nodes from EG

EG_prune = EG;

if nargin<3
    EG_prune.A(nodes1,:)=[];
    EG_prune.A(:,nodes1)=[];

    EG_prune.Abeta(:,:,nodes1,:)=[];
    EG_prune.Abeta(:,:,:,nodes1)=[];

    EG_prune.nodeXY(:,nodes1)=[];
else
    for i = 1:length(keys)
        key = keys(i)
        neighbors =  nodes1(key)
        for j = 1:length(neighbors)
            EG_prune.A(key,neighbors(j))=0;
            EG_prune.A(neighbors(j),key)=0;

            EG_prune.Abeta(:,:,key,neighbors(j))=0;
            EG_prune.Abeta(:,:,neighbors(j),key)=0;
        end
    end
    
    null_nodes = find(sum(EG_prune.A)==0);
    
    EG_prune.A(null_nodes,:)=[];
    EG_prune.A(:,null_nodes)=[];

    EG_prune.Abeta(:,:,null_nodes,:)=[];
    EG_prune.Abeta(:,:,:,null_nodes)=[];
       
    EG_prune.nodeXY(:,null_nodes)=[];
end
    
[G,H,~] = adj2GH(EG_prune.A);
EG_prune.G = G;
EG_prune.H = H;
beta = adj2beta(EG_prune.Abeta,EG_prune.A);
EG_prune.beta = beta;