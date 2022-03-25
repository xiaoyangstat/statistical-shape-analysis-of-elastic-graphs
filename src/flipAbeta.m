function Abeta = flipAbeta(Abeta,A)
% fill out the lower triangle of Abeta

n = size(A);

for i =1:n
    for j = 1:i-1
        if A(i,j)>0
            Abeta(:,:,i,j) = fliplr(Abeta(:,:,j,i));
        end
    end
end
