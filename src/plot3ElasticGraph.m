function plot3ElasticGraph(beta,A,nodeLabel,FontSize,color,threshold)

if nargin<3
    nodeLabel = false;
    FontSize = 16;
end

if nargin<4
    FontSize = 16;
end

if nargin<5
    color = 'b';
end

if nargin<6
    threshold = 0;
end

node_color = 'r';

for i = 1:size(A,1)
    for j = i+1:size(A,2) %upper triangle
        if A(i,j)==1
            plot3(beta(1,:,i,j),beta(2,:,i,j),beta(3,:,i,j),'Color',color,'LineWidth',2)                
            if nodeLabel
                hold on
                plot3(beta(1,1,i,j),beta(2,1,i,j),beta(3,1,i,j),'Color',node_color,'Marker','o','LineWidth',2)
                text(beta(1,1,i,j),beta(2,1,i,j),beta(3,1,i,j),num2str(i),'FontSize',FontSize)
                hold on 
                plot3(beta(1,end,i,j),beta(2,end,i,j),beta(3,end,i,j),'Color',node_color,'Marker','o','LineWidth',2)
                text(beta(1,end,i,j),beta(2,end,i,j),beta(3,end,i,j),num2str(j),'FontSize',FontSize)
            end
            hold on
        elseif A(i,j)<1 && A(i,j)>threshold %5/92
            plot3(beta(1,:,i,j),beta(2,:,i,j),beta(3,:,i,j),'Color',color,'LineWidth',2*A(i,j))                
            if nodeLabel
                hold on
                plot3(beta(1,1,i,j),beta(2,1,i,j),beta(3,1,i,j),'Color',node_color,'Marker','o','LineWidth',2)
                text(beta(1,1,i,j),beta(2,1,i,j),beta(3,1,i,j),num2str(i),'FontSize',FontSize)
                plot3(beta(1,end,i,j),beta(2,end,i,j),beta(3,end,i,j),'Color',node_color,'Marker','o','LineWidth',2)
                text(beta(1,end,i,j),beta(2,end,i,j),beta(3,end,i,j),num2str(j),'FontSize',FontSize)
            end
            hold on
        end
    end
end
hold off;