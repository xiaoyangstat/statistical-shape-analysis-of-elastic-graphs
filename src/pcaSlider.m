function pcaSlider(muEG,mu,eigenvector,latent,a,d,T,nmax,axLimit,viewAngel)

if nargin<10
    viewAngelFlag = false;
    viewAngel = [];
else
    viewAngelFlag = true;
end

gif_flag =false;

n = length(a);
for i = 1:n
    if latent>=0 % single score reconstruction
        modesEG(i) = getPCAmodes(muEG,mu,eigenvector,latent,a(i),d,T,nmax);
    else % multivariate reconstruction
        modesEG(i) = getPCAmodes(muEG,mu,eigenvector,latent,a(:,i),d,T,nmax);
    end
end

figure
hf = gcf;
%plotElasticGraph(modesEG(1).Abeta,modesEG(1).A,false,'12','b',1/10)
plotElasticGraph(modesEG(1).Abeta,modesEG(1).A)
axis(axLimit);
axis equal off
title(a(1))
if viewAngelFlag
    view(viewAngel);
end
if gif_flag
gif('slider.gif','LoopCount',1,'DelayTime',1/5)
end

wd = get(hf,'position');
wd = wd(3);
h = uicontrol('style','slider','units','pixels','position',[20,0,wd-40,20],'min',0,'max',1);
addlistener(h,'ContinuousValueChange',...
    @(hObject, event) makeplot(hObject,n,a,modesEG,hf,axLimit,viewAngelFlag,viewAngel,gif_flag));


function makeplot(hObject,n,a,modesEG,hf,axLimit,viewAngelFlag,viewAngel,gif_flag)
figure(hf);
i = round(get(hObject,'Value')*(n-1) + 1);
%plotElasticGraph(modesEG(i).Abeta,modesEG(i).A,false,'12','b',1/10)
plotElasticGraph(modesEG(i).Abeta,modesEG(i).A)
axis(axLimit);
axis equal off
title(a(i))
if viewAngelFlag
    view(viewAngel);
end
if gif_flag
gif
end