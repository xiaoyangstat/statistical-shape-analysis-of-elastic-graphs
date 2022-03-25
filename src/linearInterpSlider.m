function linearInterpSlider(EG1,EG2,a,nodeLabel,viewAngel,axLimit,colors)

n1 = size(EG1.A,1);n2 = size(EG2.A,1);
[EG1s, EG2s] = addOneWayNullNodes(EG1,EG2);
[EG1r,EG2r] = assignNullNodes(EG1s,EG2s,1:max([n1 n2]),n1,n2);
EG1 = interpEGAbeta(EG1r);
EG2 = interpEGAbeta(EG2r);

if nargin<4
    nodeLabel = true;
end

if nargin<5
    viewAngel = [];
    viewAngelFlag = false;
else
    viewAngelFlag = true;
end

if nargin<6
    axLimit = findAxis(EG1,EG2);
    colors=[];
end

if nargin<7
    colors=[];
end


n = length(a);

figure
hf = gcf;
plotEGcombination(EG1,EG2,a(1),nodeLabel,colors);
axis(axLimit);
if viewAngelFlag
    view(viewAngel);
end

wd = get(hf,'position');
wd = wd(3);
h = uicontrol('style','slider','units','pixels','position',...
    [20,0,wd-40,20],'min',0, 'max',1);
addlistener(h,'ContinuousValueChange',...
    @(hObject, event) makeplot(hObject,n,EG1,EG2,a,hf,axLimit,viewAngelFlag,viewAngel,nodeLabel,colors));


function makeplot(hObject,n,EG1,EG2,a,hf,axLimit,viewAngelFlag,viewAngel,nodeLabel,colors)
figure(hf);
i = round(get(hObject,'Value')*(n-1) + 1);
plotEGcombination(EG1,EG2,a(i),nodeLabel,colors);
axis(axLimit);
if viewAngelFlag
    view(viewAngel);
end


function axLimit = findAxis(EG1,EG2)

if size(EG1.Abeta,1)==3
    figure(999)
    plot3ElasticGraph(EG1.Abeta,EG1.A);
    ax1 = gca;
    figure(998)
    plot3ElasticGraph(EG2.Abeta,EG2.A);
    ax2 = gca;
    XLim = [ax1.XLim ax2.XLim];
    YLim = [ax1.YLim ax2.YLim];
    ZLim = [ax1.ZLim ax2.ZLim];
    axLimit = [min(XLim) max(XLim) min(YLim) max(YLim) min(ZLim) max(ZLim)];
else
    figure(999)
    plotElasticGraph(EG1.Abeta,EG1.A);
    ax1 = gca;
    figure(998)
    plotElasticGraph(EG2.Abeta,EG2.A);
    ax2 = gca;
    XLim = [ax1.XLim ax2.XLim];
    YLim = [ax1.YLim ax2.YLim];
    axLimit = [min(XLim) max(XLim) min(YLim) max(YLim)];
end
close([998 999])