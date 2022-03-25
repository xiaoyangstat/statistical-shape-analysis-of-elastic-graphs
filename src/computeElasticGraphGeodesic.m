function Abeta_a = computeElasticGraphGeodesic(EG1,EG2,a,Aa,nodeXYa,linearFlag)
% 

Abeta1 = EG1.Abeta;
Abeta2 = EG2.Abeta;

Abeta_a = zeros(size(Abeta1));

m1 = size(Aa,1);
m2 = m1;

nullEdge = zeros(size(Abeta1,1),size(Abeta1,2));

% if linearFlag
%     fprintf('linear interpolation\n')
% end

if a==1
    Abeta_a = Abeta1;
    return;
elseif a==0
    Abeta_a = Abeta2;
    return;
else
    for i = 1:m1
        for j = i+1:m2 % upper triangle
            if Aa(i,j)==1 % common edge
                rawShape = computeElasticGeodesic(Abeta1(:,:,i,j),Abeta2(:,:,i,j),a,linearFlag);
                Abeta_a(:,:,i,j) = shape2curve(rawShape,nodeXYa(:,i),nodeXYa(:,j));
            elseif Aa(i,j)==0
                continue
            else
                if EG1.A(i,j)==1 % edge in graph 1 shrinking
                    rawShape = computeElasticGeodesic(Abeta1(:,:,i,j),nullEdge,a,linearFlag);
                    Abeta_a(:,:,i,j) = shape2curve(rawShape,nodeXYa(:,i),nodeXYa(:,j));
                else
                    rawShape = computeElasticGeodesic(nullEdge,Abeta2(:,:,i,j),a,linearFlag);
                    Abeta_a(:,:,i,j) = shape2curve(rawShape,nodeXYa(:,i),nodeXYa(:,j));
                end
            end
        end
    end
end