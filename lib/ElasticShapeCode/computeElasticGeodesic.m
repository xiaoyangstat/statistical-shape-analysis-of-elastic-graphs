function c = computeElasticGeodesic(beta1,beta2,alpha,linearFlag)
% first transform beta_i to q_i
% then align q2 to q1 get q2n
% finally compute alpha*q1+(1-alpha)*q2n
% return curve
q1 = curve_to_q(beta1);
q2 = curve_to_q(beta2);

%% linear interpolation (has registered)
if linearFlag
    qa = alpha*q1+(1-alpha)*q2;
else
%% shape interpolation
    q1n = Find_Rotation_and_Seed_unique(q2,q1);
    % q1n = q1n/sqrt(InnerProd_Q(q1n,q1n)+eps);
    qa = alpha*q1n+(1-alpha)*q2;
end

c = q_to_curve(qa);
