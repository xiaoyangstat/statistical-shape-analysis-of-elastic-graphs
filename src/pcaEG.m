function [eigenvectors,scores,latent,explained,mu]= pcaEG(EG)
% 
% Arguments:
%   EG: sample EGs, list format.

V = Abeta2qV(EG(1).Abeta);

for i = 2:length(EG)
    fprintf('vectorizing %d out of %d\n',i,length(EG));
    V = [V; Abeta2qV(EG(i).Abeta)];
end

[eigenvectors,scores,latent,~,explained,mu] = pca(V);

end

function qV = Abeta2qV(Abeta)

Abetaq = zeros(size(Abeta));

n = size(Abeta,3);
l = 0;
for i = 1:n
    for j = i+1:n
        q = curve_to_q(Abeta(:,:,i,j),false);
        l = l + sqrt(InnerProd_Q(q,q));
        Abetaq(:,:,i,j) = q;
    end
end

l = 1; % unscaled

qV = [];
for i = 1:n
    for j = i+1:n
        q = Abetaq(:,:,i,j)/l;
        qV = [qV q(:)'];
    end
end

end