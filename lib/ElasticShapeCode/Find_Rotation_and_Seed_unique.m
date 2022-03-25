function [q2best,Rbest] = Find_Rotation_and_Seed_unique(q1,q2)
% This function returns a locally optimal rotation and seed point for shape
% q2 w.r.t. q1

minE = -999999;
q2best = q2;

for ctr = 1:1
    [q2n,R] = Find_Best_Rotation(q1,q2best,true);
    
    if norm(q1-q2n,'fro') > 0.0001
        gamI = DynamicProgrammingQ_adam(q2n,q1,0,0);
        gamI = (gamI-gamI(1))/(gamI(end)-gamI(1));
        p2n = q_to_curve(q2n);
        p2new = Group_Action_by_Gamma_Coord(p2n,gamI);
        q2new = curve_to_q(p2new);
    else
        q2new = q2n;
    end
        
    Ec = (InnerProd_Q(q1,q2new));
    
    if Ec > minE
        Rbest=R;
        q2best = q2new;
        minE = Ec;
    end
end

end