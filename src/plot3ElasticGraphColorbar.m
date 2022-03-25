function plot3ElasticGraphColorbar(EG,nodeLabel,FontSize,threshold)

beta = EG.Abeta;
A = EG.A;
edgeWidth = unique(A);

node_color = 'r';

cmap = cool(length(edgeWidth)); % Initialize jet colormap.


for i = 1:size(A,1)
    for j = i+1:size(A,2) %upper triangle
        if A(i,j)==1
            index = find(edgeWidth == A(i,j));
            plot3(beta(1,:,i,j),beta(2,:,i,j),beta(3,:,i,j),'Color',cmap(index,:),'LineWidth',2*A(i,j))
            colorbar
            caxis([0,1])
            colormap cool
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
            index = find(edgeWidth == A(i,j));
            plot3(beta(1,:,i,j),beta(2,:,i,j),beta(3,:,i,j),'Color',cmap(index,:),'LineWidth',2*A(i,j))
            colorbar
            caxis([0,1])
            colormap cool
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