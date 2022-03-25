function fn = Group_Action_by_Gamma_Coord(f,gamma)

[d,T] = size(f);

for j=1:d
    fn(j,:) = interp1(linspace(0,1,T) , f(j,:) ,gamma);
end

return;