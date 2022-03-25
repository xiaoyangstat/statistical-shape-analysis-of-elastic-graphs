function gamma = generateRandomWarping(T)

t = linspace(0,1,T);

a = round(10*rand,1);
b = round(10*rand,1);

gamma = betacdf(t,a,b);