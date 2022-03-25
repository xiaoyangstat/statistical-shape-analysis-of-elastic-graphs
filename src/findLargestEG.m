function [nmaxi,nmax] = findLargestEG(EG)

nmax = size(EG(1),1);nmaxi=1;

for i = 2:length(EG)
    if size(EG(i).A,1)>nmax
        nmax = size(EG(i).A,1);
        nmaxi = i;
    end
end

end