function Xn = resampleCurve(X,N)

[d,T] = size(X);

if d==3
    if T<=2
        Xn(1,:) = linspace(X(1,1),X(1,2),N);
        Xn(2,:) = linspace(X(2,1),X(2,2),N);
        Xn(3,:) = linspace(X(3,1),X(3,2),N);
        return
    end

    old_t = linspace(0,1,T);
    new_t = linspace(0,1,N);

    Xn(1,:) = interp1(old_t,X(1,:),new_t,'spline');
    Xn(2,:) = interp1(old_t,X(2,:),new_t,'spline');
    Xn(3,:) = interp1(old_t,X(3,:),new_t,'spline');
else
    if T<=2
        Xn(1,:) = linspace(X(1,1),X(1,2),N);
        Xn(2,:) = linspace(X(2,1),X(2,2),N);
        return
    end

    old_t = linspace(0,1,T);
    new_t = linspace(0,1,N);

    Xn(1,:) = interp1(old_t,X(1,:),new_t,'spline');
    Xn(2,:) = interp1(old_t,X(2,:),new_t,'spline');
end