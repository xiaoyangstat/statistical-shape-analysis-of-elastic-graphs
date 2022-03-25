function modesEG= getPCAmodes(muEG,mu,eigenvector,latent,alpha,d,T,nmax)

if latent<0 % 
    % alpha: d by 1
    fprintf('multivariate scores reconstruction\n')
    qV = mu'+eigenvector*alpha;
else % single score reconstruction
    fprintf('single score reconstruction\n')
    qV = mu'+alpha*sqrt(latent)*eigenvector;
end

Abetaq = reshape_qV(qV,d,T,nmax);
Abeta = adjq2beta(Abetaq,ones(nmax,nmax));
modesEG = muEG;
modesEG.Abeta = Abeta;
% A = zeros(nmax,nmax);
% for i = 1:nmax
%     for j = i+1:nmax
%         if norm(Abeta(:,:,i,j))>0
%             A(i,j) = 1;
%         end
%     end
% end
% A = A+A';
% modesEG.A = A;
modesEG = interpEGAbeta(modesEG);