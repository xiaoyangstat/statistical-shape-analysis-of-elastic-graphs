% % test 1
%  A = [0 1 0 0 0; 1 0 1 0 0; 0 1 0 0 0; 0 0 0 0 1; 0 0 0 1 0];
% % test 2
% % A = [0 1; 1 0];
% 
% 
% cc = findConnectedComponents(A);

function cc = findConnectedComponents(A)
n = size(A,1);

global visited 
visited = zeros(1,n);
j = 1;
for i = 1:n
    if ~visited(i)
        connected_nodes= [];
        cc{j}= DFS(A,connected_nodes,i,visited);
        j = j+1;
    end
end

end

% refer to: https://www.geeksforgeeks.org/connected-components-in-an-undirected-graph/
function connected_nodes = DFS(A,connected_nodes, current_node, visited)

global visited

visited(current_node)=1;

connected_nodes = [connected_nodes current_node];

neighbors = find(A(current_node,:)==1);

for i = 1:length(neighbors)
    if ~visited(neighbors(i))
        connected_nodes = DFS(A,connected_nodes,neighbors(i),visited);
    end
end

end