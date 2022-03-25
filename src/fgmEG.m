function [p, E] = fgmEG(EG1,EG2,KQ,nodeFlag, KP)
% factorized graph matching (fgm)
% permute EG1's node order to match EG2
%
% Args:
%   EG1, EG2: equal size EGs
%   KQ: edge affinity matrix
%   nodeFlag: tuning parameter
%   KP: node affinity matrix
%
% Returns:
%   p: permutations list
%   E: affinity path

if nargin<4
    nodeFlag = 0;
end

n = size(EG1.A,1);

% node similarity
if nodeFlag
    fprintf('using node similarity \n');
    KP = KP*nodeFlag;
else
    fprintf('only edge similarity \n');
    KP = zeros(n,n);
end

Ct = ones(n,n); % constraint

gphs = {};
gphs{1} = EG1;
gphs{2} = EG2;
params = struct('nItMa',101,'nAlp',101','deb','n','ip','n');

fprintf('matching elastic graphs using fgm \n');
asgFgmD = fgmD(KP, KQ, Ct, gphs, [], params);

X = asgFgmD.X;
p = permat2vec(X);
E = [asgFgmD.objGm0 asgFgmD.objGms];
