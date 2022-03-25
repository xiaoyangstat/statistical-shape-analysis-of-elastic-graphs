function curve = shape2curve(rawShape,start,ending)
% Given two fixed nodes, fill the shape between them
% 
% parameters:
%   rawShape: beta (not SRVF)

% for debugging
% [d,T] = size(rawShape);
% if sum(diff(rawShape(1,:)))+sum(diff(rawShape(2,:)))+sum(diff(rawShape(3,:)))<1e-10
%     if d==3
%         curve(1,:)=linspace(start(1),ending(1),T);
%         curve(2,:)=linspace(start(2),ending(2),T);
%         curve(3,:)=linspace(start(3),ending(3),T);
%         return 
%     end
% end

%% rotation (need to be improved)
v1 = -rawShape(:,end) + rawShape(:,1);
v2 = -ending + start;

if norm(v2)==0
    curve = zeros(size(rawShape));
    return
end

% if norm(v1-v2)==0
%     curve = rawShape;
%     return
% end
try
    if length(v1)==3 %3D rotation
        %rawShape=rawShape;
        r = vrrotvec(v1,v2);
        O = vrrotvec2mat(r);
        rawShape = O*rawShape;    
    else %2D rotation
        theta = acos(dot(v1,v2)/(norm(v1)*norm(v2))); % positive countclockwise
        if imag(theta)~=0 % avoid numerical error
            theta = real(theta);
        end
        O1 = [cos(theta) -sin(theta); sin(theta) cos(theta)];
        theta = -theta;
        O2 = [cos(theta) -sin(theta); sin(theta) cos(theta)];

        if norm(O1*v1-v2)<norm(O2*v1-v2)
            rawShape = O1*rawShape;
        else
            rawShape = O2*rawShape;
        end
    end
end
%% scaling
s = norm(ending-start)/norm(rawShape(:,1)-rawShape(:,end));
rawShape = rawShape*s;

%% translation
curve = rawShape + (start - rawShape(:,1));
