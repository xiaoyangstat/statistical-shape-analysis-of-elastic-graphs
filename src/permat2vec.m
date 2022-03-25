function p = permat2vec (P)

n = size(P,1);

for i = 1:n
    for j = 1:n
        if P(i,j)
            p(j) = i;
        end
    end
end