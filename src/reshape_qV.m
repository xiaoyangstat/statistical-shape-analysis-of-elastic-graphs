function Abeta = reshape_qV(qV,d,T,n)

Abeta = zeros(d,T,n,n);

k = 1;
for i = 1:n
    for j = i+1:n
        Abeta(:,:,i,j) = reshape(qV(1+d*T*(k-1):d*T*k),d,T);
        k = k+1;
    end
end

end