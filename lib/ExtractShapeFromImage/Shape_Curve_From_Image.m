% This function extracts the boundary/contour of a black and white image.
% INPUT  : dirname: string, directory name where the image files reside.
% OUTPUT : [X,Y]  : X,Y co-ordinates of the closed curves
% Author: Shan H. Joshi
% Date  : 01/30/04

function Shape_Curve_From_Image;

NUM_SAMPLES = 100;

dirname = uigetdir('','Select Directory');
if isequal(dirname,0)
    disp('User pressed cancel OR selection is not a valid directory')
    return;
end
file_list = dir(dirname);

file_list = file_list(3:end);
curdir = cd;
destdir = fullfile(curdir,'Cur_Extracted_Shapes');
[stat,mess]=fileattrib('destdir');
if(stat == 0)    % Directory doesn't exist
    [status,message,messageid] = mkdir('Cur_Extracted_Shapes');
end
delete([destdir,'/*']);

% 
% [filename, pathname] = uigetfile({'*.jpg';'*.pgm';'*.pbm';'*.bmp';'*.*'},'Select an Image');
% if isequal(filename,0) | isequal(pathname,0)
%     disp('User pressed cancel')
%     return;
% else
% %     disp(['User selected ', fullfile(pathname, filename)])
% end

h_filt = fspecial('gaussian',10,4);

for i = 1:length(file_list)
    file_full_path = fullfile(dirname,file_list(i).name);
    filename = file_list(i).name ;
    pathname = file_full_path;
    pathname
    I = readpgm(pathname);
    %I = imread(file_full_path);
    % Assume the background is white
    [rowI,colI] = size(I);
    % Pad the images with white rows and columns Start with left edge
    I = [255*ones(rowI,5), I ];
    I = [255*ones(5,colI+5); I ];
    I = [I , 255*ones(rowI+5,5)];
    I = [I; 255*ones(5,colI+10)];    
    
    I = imfilter(I,h_filt);     % Low pass filter
    [C,H] = imcontour(I,1);
    Xtemp = get(H,'Xdata');
    Ytemp = get(H,'Ydata');    
    clear rows; clear cols;
    if (iscell (Xtemp) )
        % Select the largest size cell array
        for j = 1:length(Xtemp)
            % Note this is a column vector
            [rows(j),cols] = size(Xtemp{j});    
        end
        [maxval,idx] = max(rows);
        Xtemp = Xtemp{idx};
        Ytemp = Ytemp{idx};        
    end
    nanelems = isnan(Xtemp);
    Xtemp = Xtemp(~nanelems);
    Ytemp = Ytemp(~nanelems);
    [Xnew,Ynew,Theta(i,:),success] = resamplecurve_new(Xtemp,Ytemp,NUM_SAMPLES);   % Downsample the curve to N points using splines on the tangent function 
    
    %     figure;plot(Xnew,Ynew,'Linewidth',2);axis equal;
    delete(figure(i));
    full_file_name_str=fullfile(pathname,filename);
    
    filename_str = sprintf('%s%s',filename,'_co_ord.mat');
    filename_to_save = fullfile(destdir,filename_str);
    save(filename_to_save,'Xnew','Ynew','full_file_name_str','Theta');
    sprintf('File %s saved succesfully',filename_str)
end
delete(figure(1));
Gather_Shapes_Auto(destdir);