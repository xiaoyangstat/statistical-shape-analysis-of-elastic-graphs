function plot3ElasticGraphSubset(beta,A,d,color,threshold1,threshold2)
% plot 3d EG based on the extra attribute d
%
colors = distinguishable_colors(500);

k = 1;
for i = 1:size(A,1)
    for j = i+1:size(A,2) %upper triangle
        if A(i,j)>threshold1 && d(i,j)>threshold2
            plot3(beta(1,:,i,j),beta(2,:,i,j),beta(3,:,i,j),'color',colors(k,:),'LineWidth',2)                
            k = k + 1;
        end
    end
end
hold off;