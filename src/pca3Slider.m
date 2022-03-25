function pca3Slider(muEG,mu,eigenvector,latent,a,d,T,nmax,axLimit,viewAngel)

if nargin<10
    viewAngelFlag = false;
    viewAngel = [];
else
    viewAngelFlag = true;
end

gif_flag =true;

n = length(a);
for i = 1:n
    modesEG(i) = getPCAmodes(muEG,mu,eigenvector,latent,a(:,i),d,T,nmax);
end

figure
hf = gcf;
plot3ElasticGraph(modesEG(1).Abeta,modesEG(1).A,false,'b')
axis equal off
axis (axLimit);
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
plot3ElasticGraph(modesEG(i).Abeta,modesEG(i).A,false,'b')
axis equal off
axis(axLimit);
title(a(i))
if viewAngelFlag
    view(viewAngel);
end

if gif_flag
    gif
end