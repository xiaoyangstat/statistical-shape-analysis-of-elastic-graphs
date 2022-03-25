function T =EnergyStat2sample(D)


% D: 2*2 cell
% X,Y: cell

DX = D{1,1};
DY = D{2,2};
DXY = D{1,2};


nx = size(DX,1);
ny = size(DY,1);






T = nx*ny/(nx+ny)*(2*mean(DXY(:))- mean(DX(:)) - mean(DY(:)));

