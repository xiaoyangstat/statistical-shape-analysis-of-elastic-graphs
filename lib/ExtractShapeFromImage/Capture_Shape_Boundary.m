% This function displays an image in a window and enables the user to trace 
% out any boundary that he wants from that image.
% The user should press the button once at the starting point then move 
% the mouse (without releasing the button) along the desired boundary 
% The shape co-ordinates are available immediately after button release. 
% The user can also do a piecewise capture of the boundary.

% Author: Shan H. Joshi
% Date  : 07-17-03
% Date  : 20-07-02 % Update the plotting procedure

%function [Xnew,Ynew] = Capture_Shape_Boundary(file_name,N);
% function [Xnew,Ynew] = Capture_Shape_Boundary()
% 

[filename, pathname] = uigetfile({'*.jpg';'*.pgm';'*.pbm';'*.bmp';'*.*'},'Select an Image');
if isequal(filename,0) | isequal(pathname,0)
    disp('User pressed cancel')
    return;
else
%     disp(['User selected ', fullfile(pathname, filename)])
end
I = imread(fullfile(pathname, filename));

imshow(I)
hold on;

shape_coord= 0;
coord_ctr = 1;

% This is the callback for Mouse motion with the button pressed
% It captures the boundary co-ordinates and stores them in an array
fn_button_mtn_callback = [ 'pt = get(gca,''CurrentPoint'');'...
						      	'shape_coord(coord_ctr,1)= pt(1,1);' ...
					            'shape_coord(coord_ctr,2)= pt(1,2);' ...
                                 'plot(pt(1,1),pt(1,2));'...
                                 ' text(pt(1,1),pt(1,2),''+'') ;' ...
					            'coord_ctr = coord_ctr + 1;'];
                     
% This is the callback for the Mouse button pressed
% This displays a '+' symbol on the shape and also registers the WindowButtonMotionFcn callback
fn_button_dwn_callback =[' pt = get(gca,''CurrentPoint'');' ...
      						 ' text(pt(1,1),pt(1,2),''+'') ;' ...
                         ' set(gcf,''WindowButtonMotionFcn'',fn_button_mtn_callback)'];
                   
% This is the callback for the Mouse button released
% This un-registers the callback for mouse motion
fn_button_up_callback =[' pt = get(gca,''CurrentPoint'');'...
						      ' text(pt(1,1),pt(1,2),''+''); ' ...
				      		' set(gcf,''WindowButtonMotionFcn'','''')'];
                  
% Register the callback for WindowButtonDownFcn
set(gcf,'WindowButtonDownFcn',fn_button_dwn_callback);

% Register the callback for WindowButtonUpFcn
set(gcf,'WindowButtonUpFcn',fn_button_up_callback );

pause;
% Retrieve the X and Y co-ordinates
clear Xnew; clear Ynew;
Xnew = shape_coord(:,1)';
Ynew = shape_coord(:,2)';

% Resample the curve to N points
% [Xnew,Ynew,success] = resamplecurve(Xtest,Ytest,100);
figure;plot(Xnew,Ynew);axis equal; axis ij;
