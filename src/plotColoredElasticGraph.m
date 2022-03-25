function colors = plotColoredElasticGraph(Abeta,A,A1A2,colors)

if isempty(colors)
    colors = distinguishable_colors(500);
end

k = 1;
for i = 1:size(A,1)
    for j = i+1:size(A,2) % upper triangle
        if A1A2(i,j) > 0
            plot(Abeta(1,:,i,j),Abeta(2,:,i,j),'color',colors(k,:),'LineWidth',1*A(i,j)+0.01)
            k = k + 1;
            hold on
        end
    end
end
hold off;