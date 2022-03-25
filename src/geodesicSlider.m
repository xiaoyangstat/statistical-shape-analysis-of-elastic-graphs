function colors = geodesicSlider(EG1,EG2,a,nodeLabel,viewAngel,axLimit,gif_flag,gif_path)

if nargin<4
    nodeLabel = true;
end

if nargin<5
    viewAngelFlag = false;
    viewAngel = [];
    gif_flag = false;
    gif_path = 'slider.gif';
elseif isempty(viewAngel)
    viewAngelFlag = false;
else
    viewAngelFlag = true;
end

if nargin<6
    axLimit = findAxis(EG1,EG2);
    gif_flag = false;
    gif_path = 'slider.gif';
end


% if size(EG1.Abeta,1)==3
%     EG1 = icpEG(EG1,EG2);
% end

n = length(a);

figure
hf = gcf;
colors = plotEGcombination(EG1,EG2,a(1),nodeLabel,[]);
axis equal off
axis(axLimit);

if viewAngelFlag
    view(viewAngel);
end

if gif_flag
    gif(gif_path,'LoopCount',1,'DelayTime',1/5)
end

wd = get(hf,'position');
wd = wd(3);
h = uicontrol('style','slider','position',[20,10,wd-300,20],'min',0, 'max',1.05);
addlistener(h,'ContinuousValueChange',...
    @(hObject, event) makeplot(hObject,n,EG1,EG2,a,hf,axLimit,viewAngelFlag,viewAngel,nodeLabel,gif_flag));

end


function makeplot(hObject,n,EG1,EG2,a,hf,axLimit,viewAngelFlag,viewAngel,nodeLabel,gif_flag)
  figure(hf);
  get(hObject,'Value');
  i = min([n round(get(hObject,'Value')*n)]);
  plotEGcombination(EG1,EG2,a(i),nodeLabel,[]);
  axis equal off
  axis(axLimit)

if viewAngelFlag
    view(viewAngel);
end

if gif_flag
    gif
end

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
      axLimit = 1*axLimit;
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
end
