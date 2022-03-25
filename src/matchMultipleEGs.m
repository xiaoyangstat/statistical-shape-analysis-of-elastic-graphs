function EGp = matchMultipleEGs(EG,nodeFlag,landmarks)
% Match multiple EG;
% First zero padding all the EG to size of the largest one
% (Note this is one way padding). Then match all the EGs to the largest one
%
% Args:
%   EG:
%   nodeFlag: false or 0 vs a positive number
%   landmarks: true/false

if nargin<2
    nodeFlag = false;
    landmarks = false;
end
if nargin<3
    landmarks = false;
end

interp = false;

%% find the largest EG
nmax = 1;
for i = 1:length(EG)
    ni = size(EG(i).A,1);
    if nmax < ni
        nmax = ni;
        imax = i;
    end
end

%% matching
for i = 1:length(EG)
    fprintf('matching %d EG out of %d\n',i,length(EG));
    if i==imax
        EGp(i) = EG(i);
        continue
    else
        ni = size(EG(i).A,1);
        EGi = addNullNodes(EG(i),nmax-ni);
        KQ = computeKQ(EGi.beta,EG(imax).beta);
        KP = zeros(nmax,nmax); 
        if nodeFlag
            KP(1:ni,:) = computeKP(EG(i).nodeXY,EG(imax).nodeXY,100);
            if landmarks
                for j = 1:length(EGi.landmarks)
                    KP(EG(i).landmarks(j),EG(imax).landmarks(j))=1e3;
                end
            end
        end
        [p, ~] = fgmEG(EGi,EG(imax),KQ,nodeFlag,KP);
        EGp(i) = permutateElasticGraphs(EGi,p,EG(imax));

        if interp
            EGp(i) = interpEGAbeta(EGp(i));
        end

    end
end

