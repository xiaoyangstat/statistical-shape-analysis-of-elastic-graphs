function colors=plotEGcombination(EG1,EG2,a,nodeLabel,colors,translation)

A1 = EG1.A;
A2 = EG2.A;

dim = size(EG1.Abeta,1);

if nargin<6
    translation = zeros(dim,1);
end

aA = a*A1 + (1-a)*A2;
nodeXYa = a*EG1.nodeXY + (1-a)*EG2.nodeXY + translation;
aAbeta = computeElasticGraphGeodesic(EG1,EG2,a,aA,nodeXYa,1);

if dim==2
    %plotElasticGraph(aAbeta,aA,nodeLabel);
    colors = plotColoredElasticGraph(aAbeta,aA,A1+A2,colors);
else
    %plot3ElasticGraph(aAbeta,aA,nodeLabel);
    colors = plot3ColoredElasticGraph(aAbeta,aA,A1.*A2,colors);
end
%title(['a= ' num2str(a)],'FontSize',20)
