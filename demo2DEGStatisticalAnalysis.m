clear;close all;
addPath;
font_size = 18;

%% Simulate 4 EGs
T = 101;sig = 0.1;

% Create EG1
mainBranch = create2DCurve([0;0],[0.5;1],T,sig);

node1=[0;0];node2=mainBranch(:,25);node3=[-0.1;0.35];node4=mainBranch(:,50);
node5=[0.35;0.55];node6=mainBranch(:,75);node7=[-0.05;0.85];node8=[0.5;1];
nodeXY = [node1 node2 node3 node4 node5 node6 node7 node8];

n = size(nodeXY,2); Abeta = zeros(2,T,n,n);A = zeros(n,n);

i=1;j=2; c = resampleCurve(mainBranch(:,1:25),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=3; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=4; c = resampleCurve(mainBranch(:,25:50),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=5; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=6; c = resampleCurve(mainBranch(:,50:75),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=6;j=7; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=6;j=8; c = resampleCurve(mainBranch(:,75:end),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=7; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=5; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;

[G,H,~] = adj2GH(A);
EG1 = struct('Abeta',Abeta,'beta',adj2beta(Abeta,A),'nodeXY',nodeXY,'A',A,'G',G,'H',H);

% Create EG2
i=1;j=2; c = resampleCurve(mainBranch(:,1:25),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=3; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=4; c = resampleCurve(mainBranch(:,25:50),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=5; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=6; c = resampleCurve(mainBranch(:,50:75),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=6;j=7; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=6;j=8; c = resampleCurve(mainBranch(:,75:end),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=7; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=5; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;

[G,H,~] = adj2GH(A);
EG2 = struct('Abeta',Abeta,'beta',adj2beta(Abeta,A),'nodeXY',nodeXY,'A',A,'G',G,'H',H);
EG2 = permutateElasticGraphs(EG2,randperm(8));

% Create EG3
i=1;j=2; c = resampleCurve(mainBranch(:,1:25),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=3; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=4; c = resampleCurve(mainBranch(:,25:50),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=5; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=6; c = resampleCurve(mainBranch(:,50:75),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=6;j=7; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=6;j=8; c = resampleCurve(mainBranch(:,75:end),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=7; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=5; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;

[G,H,~] = adj2GH(A);
EG3 = struct('Abeta',Abeta,'beta',adj2beta(Abeta,A),'nodeXY',nodeXY,'A',A,'G',G,'H',H);
EG3 = permutateElasticGraphs(EG3,randperm(8));

% Create EG4
i=1;j=2; c = resampleCurve(mainBranch(:,1:25),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=3; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=4; c = resampleCurve(mainBranch(:,25:50),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=5; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=6; c = resampleCurve(mainBranch(:,50:75),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=6;j=7; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=6;j=8; c = resampleCurve(mainBranch(:,75:end),T);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=4;j=7; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;
i=2;j=5; c = create2DCurve(nodeXY(:,i),nodeXY(:,j),T,sig);
Abeta(:,:,i,j) = c; Abeta(:,:,j,i) =fliplr(c);A(i,j)=1;A(j,i)=1;

[G,H,~] = adj2GH(A);
EG4 = struct('Abeta',Abeta,'beta',adj2beta(Abeta,A),'nodeXY',nodeXY,'A',A,'G',G,'H',H);
EG4 = permutateElasticGraphs(EG4,randperm(8));

%% Samples 
EG(1) = EG1; EG(2) = EG2;EG(3) = EG3; EG(4) = EG4;

figure
subplot(1,4,1)
plotElasticGraph(EG(1).Abeta,EG(1).A,true,font_size)
axis equal off
subplot(1,4,2)
plotElasticGraph(EG(2).Abeta,EG(2).A,true,font_size)
axis equal off
subplot(1,4,3)
plotElasticGraph(EG(3).Abeta,EG(3).A,true,font_size)
axis equal off
subplot(1,4,4)
plotElasticGraph(EG(4).Abeta,EG(4).A,true,font_size)
axis equal off
sgtitle('Sample EGs')

%% Multiple Matching
EGp = matchMultipleEGs(EG);

for i = 1:length(EGp)
    EGpv(i) = interpEGAbeta(EGp(i));
end

figure
subplot(1,4,1)
plotElasticGraph(EGpv(1).Abeta,EGpv(1).A,true,font_size)
axis equal off
subplot(1,4,2)
plotElasticGraph(EGpv(2).Abeta,EGpv(2).A,true,font_size)
axis equal off
subplot(1,4,3)
plotElasticGraph(EGpv(3).Abeta,EGpv(3).A,true,font_size)
axis equal off
subplot(1,4,4)
plotElasticGraph(EGpv(4).Abeta,EGpv(4).A,true,font_size)
axis equal off
sgtitle('Matched Sample EGs')


muEGp = avgEG(EGp);

muEG = avgEG(EG);

figure
subplot(1,2,1)
plotElasticGraph(muEG.Abeta,muEG.A,false)
title('Unmatched Mean')
axis equal off
subplot(1,2,2)
plotElasticGraph(muEGp.Abeta,muEGp.A,false)
axis equal off
title('Matched Mean')

%% PCA
[eigenvectors,scores,latent,explained,mu] = pcaEG(EGp);

figure
subplot(121)
plot(latent,'o-')
title('Singular Value')
subplot(122)
plot(cumsum(explained),'o-')
title('Cumulative Explaination')
sgtitle('PCA')

a = linspace(-2,2,5);
n = length(a);
for i = 1:n
    modesEG(i) = getPCAmodes(muEGp,mu,eigenvectors(:,1),latent(1),a(i),2,101,8);
end

figure
for i = 1:(length(a))
    subplot(1,5,i)
    plotElasticGraph(modesEG(i).Abeta,modesEG(i).A,false)
    axis equal off
end
sgtitle('Variations Along 1st PC Direction')

