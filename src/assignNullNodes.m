function [EG1p,EG2] = assignNullNodes(EG1p,EG2,p,n1,n2)
% after graph matching, assign node attributes to null nodes
% should be used after one way padding
%
% Args:
%   n1: orignal size of G1
%   n2: orignal size of G2

if n1<=n2
    for i=1:n2 %i is real node of G2
        if p(i)>n1 %p(i): original node of G1 => G1 null node to G2 real node
           EG1p.nodeXY(:,i) = EG2.nodeXY(:,i);
        end
    end
else
    for i = n2+1:n1
        EG2.nodeXY(:,i) = EG1p.nodeXY(:,i);
    end
end

end