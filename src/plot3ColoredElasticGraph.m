function colors = plot3ColoredElasticGraph(Abeta,A,A1A2,colors)

if nargin<3
    A1A2 = A;
    colors = distinguishable_colors(500);
end
if isempty(colors)
    colors = distinguishable_colors(500);
end

k = 1;
for i = 1:size(A,1)
    for j = i+1:size(A,2) %upper triangle
%         if A1A2(i,j)>0 && A1A2(i,j)<=1
%             k = k + 1;
%             continue
%         end
        if A1A2(i,j)>0
            plot3(Abeta(1,:,i,j),Abeta(2,:,i,j),Abeta(3,:,i,j),'color',colors(k,:),'LineWidth',2*A(i,j)+0.01)
%             ratio = 2*(colors(i,j)-mi)/(ma-mi);
%             r = max(0, 255*(ratio - 1));
%             b = max(0, 255*(1 - ratio));
%             c = [r 255-r-b b]/255; 
            % https://stackoverflow.com/questions/20792445/calculate-rgb-value-for-a-range-of-values-to-create-heat-map
%            plot3(Abeta(1,:,i,j),Abeta(2,:,i,j),Abeta(3,:,i,j),'color',c,'LineWidth',2);%2*A(i,j)+0.01);
            k = k + 1;
            hold on
        end
    end
end
hold off;