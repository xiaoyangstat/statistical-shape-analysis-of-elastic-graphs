function beta = adj2beta(Abeta,A)
% convert adjacency beta matrix to beta array

n = size(A,1);
k = 1;

for i = 1:n
    for j = i+1:n
        if A(i,j)
            beta(:,:,k) = Abeta(:,:,i,j);
            k = k+1;
        end
    end
end
