clear;close all;
addPath;

%% Permute to Iterself
n = 5; p = 0.5; sig = 0.1; T = 100; 
EG1 = create2DElasticGraph(n,p,T,sig);

pTrue = randperm(n);
EG2 = permutateElasticGraphs(EG1,pTrue);

EG1p = matchEG(EG1,EG2);

figure
subplot(1,3,1)
plotElasticGraph(EG1.Abeta,EG1.A,true);
title('Original: E1')
subplot(1,3,2)
plotElasticGraph(EG1p.Abeta,EG1p.A,true);
title('Recovered: E1p')
subplot(1,3,3)
plotElasticGraph(EG2.Abeta,EG2.A,true);
title('Ground truth: E2')

%% Match Two EGs with Different Sizes
p = 0.5; sig = 0.1; n1 = 5; n2 = 6; T = 50;
EG1 = create2DElasticGraph(n1,p,T,sig);
EG2 = create2DElasticGraph(n2,p,T,sig);

[EG1r, EG2r, E, p] = matchEG(EG1,EG2);

figure
subplot(131)
plotElasticGraph(EG1.Abeta,EG1.A,2);
title('EG1')
subplot(132)
plotElasticGraph(EG1r.Abeta,EG1r.A,2);
title('EG1p')
subplot(133)
plotElasticGraph(EG2r.Abeta,EG2r.A,2);
title('EG2')

% geodesic
translation = [3;0];
a = linspace(0,1,5);
figure
for i = 1:(length(a)-1)
    plotEGcombination(EG1r,EG2r,a(i),false,[],(i-1)*translation);
    hold on
end
EGtemp =  interpEGAbeta(EG1r,(length(a)-1)*translation);
plotColoredElasticGraph(EGtemp.Abeta,EGtemp.A,EG1r.A+EG2r.A,[]);
axis equal
axis off

% linear interpolation
[EG1,EG2] = addOneWayNullNodes(EG1,EG2);
figure
for i = 1:(length(a)-1)
    plotEGcombination(EG1,EG2,a(i),false,[],(i-1)*translation);
    hold on
end
EGtemp =  interpEGAbeta(EG1,(length(a)-1)*translation);
plotColoredElasticGraph(EGtemp.Abeta,EGtemp.A,EG1.A+EG2.A,[]);
axis equal
axis off