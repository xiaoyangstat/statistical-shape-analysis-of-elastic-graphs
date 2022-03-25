function Abeta = adjq2beta(Abetaq,A)

n = size(A,1);

Abeta = zeros(size(Abetaq));

for i = 1:n
    for j = 1:n
        if A(i,j)
            Abeta(:,:,i,j) = q_to_curve(Abetaq(:,:,i,j));
        end
    end
end