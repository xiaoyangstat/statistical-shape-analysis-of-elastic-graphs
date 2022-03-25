function [node_pair_map,keys,values] = findNodePairs(A,degree)

if nargin<2
    degree=4;
end

keys = find(sum(A)==degree);
values = [];
node_pair_map = containers.Map('KeyType','int32','ValueType','any'); 

for i = 1:length(keys)
    neighbors = find(A(keys(i),:)==1);
    node_pair_map(keys(i)) = neighbors;
    values = [values neighbors];
end
