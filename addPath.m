function addPath

%% add fgm path
cwd = pwd;
cd('./lib/fgm/')
addPath;
cd(cwd);

%% add lib path
addpath('./lib/');
addpath('./lib/ElasticShapeCode/');
addpath('./lib/HotellingT2/');
addpath('./lib/gif/');
addpath('./lib/dijkstra/');
addpath('./lib/munkres/');
addpath('./lib/tight_subplot/');

%% add source
addpath('./src/');