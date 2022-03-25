clear; close all;
addPath;

%% Read Data
load('../data/BrainArteryTree/BrainTreeLeft.mat')

%% Matching
i1 = 0; i2 = 0; 
while i1==i2
    i1 = randi(92); 
    i2 = randi(92);
end
EG1 = EGleft(i1); EG2 = EGleft(i2);

% only using edge shape similarity
[EG1p, EG2p, ~, ~] = matchEG(EG1, EG2);

geodesicSlider(EG1p,EG2p,linspace(1,0,200),false,[-20 30]);

% also use node similarity
n1 = size(EG1.A,1);n2 = size(EG2.A,1);
n = max([n1,n2]);
KP = zeros(n,n);
% KP(1:n1,1:n2) = computeKP(sum(EG1.A),sum(EG2.A),1); 
KP(1:n1,1:n2) = computeKP(EG1.nodeXY,EG2.nodeXY,100); 
% KP(n1+1:end,n2+1:end)=0; 

[EG1p, EG2p, ~, ~] = matchEG(EG1, EG2, 30, KP);

geodesicSlider(EG1p,EG2p,linspace(1,0,200),false,[-20 30]);