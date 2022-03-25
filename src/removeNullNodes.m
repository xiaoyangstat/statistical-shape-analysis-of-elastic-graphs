function [EG1r,EG2r] = removeNullNodes(EG1p,EG2,p,n1,n2)
% after graph matching, remove the null nodes from both graphs;
% and assign node attributes to null nodes

EG1r.nodeXY = EG1p.nodeXY;
EG2r.nodeXY = EG2.nodeXY;
A1A2 = EG1p.A.*EG2.A;

for i=1:n2 %i is real node of G2
    if p(i)>n1 %p(i): original node of G1 => G1 null nodes are registered to G2 real nodes
       EG1r.nodeXY(:,i) = EG2.nodeXY(:,i);
       % for terminal null nodes, assign them attributes of the neighbor nodes to show emerging 
       if sum(EG2.A(i,:))==1
           neighbor = find(EG2.A(i,:)==1);
           if p(neighbor)<=n1
               EG1r.nodeXY(:,i) = EG1p.nodeXY(:,neighbor);
           end
       end
    end
end

deadnode = [];
for i=n2+1:n1+n2 %i is null node of G2
    if p(i)<=n1 %p(i): original node of G1 => G1 real nodes are registered to G2 null node
        EG2r.nodeXY(:,i) = EG1p.nodeXY(:,i);
        % for terminal null nodes, assign them attributes of the neighbor nodes to show emerging 
        if sum(EG1p.A(i,:))==1
           neighbor = find(EG1p.A(i,:)==1);
           if neighbor<=n2
               EG2r.nodeXY(:,i) = EG2.nodeXY(:,neighbor);
           end
        end
%         % for internal null nodes, assign them the ratio of own nodes
%         neighbors = find(EG1p.A(i,:)==1);
%         if sum(neighbors<=n2)==2
%             i
%             node1 = min(neighbors(neighbors<=n2))
%             node2 = max(neighbors(neighbors<=n2))
%             l1 = computeCurveLength(EG1p.Abeta(:,:,node1,i));
%             l2 = computeCurveLength(EG1p.Abeta(:,:,i,node2));
%             r = l1/(l1+l2)
%             c = EG2.Abeta(:,:,node1,node2);
%             l = computeCurveLength(c);            
%             best_distance = 999999;
%             for indx = 2:(size(c,2)-1)
%                 error = abs(computeCurveLength(c(:,1:indx))-l*r);
%                 if error<best_distance
%                     best_distance = error;
%                     best_indx = indx;
%                 end
%             end
%             EG2r.nodeXY(:,i) = c(:,best_indx);
%         end            
    else %null to null
        deadnode = [deadnode i];
    end
end

deadnode;

EG1r.A = EG1p.A; EG1r.A(deadnode,:)=[];EG1r.A(:,deadnode)=[];
EG1r.Abeta = EG1p.Abeta;EG1r.Abeta(:,:,deadnode,:)=[];EG1r.Abeta(:,:,:,deadnode)=[];
[EG1r.G, EG1r.H,~] = adj2GH(EG1r.A);
EG1r.beta = adj2beta(EG1r.Abeta,EG1r.A);
EG1r.nodeXY(:,deadnode)=[];

EG2r.A = EG2.A; EG2r.A(deadnode,:)=[];EG2r.A(:,deadnode)=[];
EG2r.Abeta = EG2.Abeta;EG2r.Abeta(:,:,deadnode,:)=[];EG2r.Abeta(:,:,:,deadnode)=[];
[EG2r.G, EG2r.H,~] = adj2GH(EG2r.A);
EG2r.beta = adj2beta(EG2r.Abeta,EG2r.A);
EG2r.nodeXY(:,deadnode)=[];
end

% function l = computeCurveLength(beta)
% beta1 = beta(:,1:end-1);
% beta2 = beta(:,2:end);
% l = sum(sqrt(sum((beta2-beta1).^2)));
% end