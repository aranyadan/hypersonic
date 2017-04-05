%% Function to set initial values

function [R,u,v,S,P,B,W,C] = fIC (X,Y,xs,xb)
nx = length(X);
ny = length(Y);
R = zeros(ny,nx);
u=R;
v=R;
P=R;
S=R;
B=R;
W=R;
C=R;
delta = xb-xs;
% ambient conditions
pamb=1;
Mamb=5;
rhoamb = 1;
vamb = 0;
gamma = 1.4;
aamb = (gamma*pamb/rhoamb)^0.5;
uamb = Mamb * aamb;

%% Calculating the shock angles
beta = zeros(length(xs),1);
for i=1:length(beta)-1
   beta(i) = atan2((Y(2)-Y(1)),xs(i+1)-xs(i)); 
end
beta(i+1) = beta(i);

%% Calculating quantities after the shock
MB = (Mamb.*sin(beta)).^2;
p2 = pamb * (1 + (2*gamma/(gamma+1))) * (MB-1);
rho2 = rhoamb * ((gamma+1).*MB)./((gamma-1).*MB + 2);
u2 = (1 - 2 .* (MB - 1) ./ ((gamma+1)*Mamb^2)) * uamb;
v2 = (2 .* cot(beta) .* (MB - 1) / ((gamma+1)*Mamb^2)) * uamb;

%% Calculating body angles
by = zeros(length(xb),1);
for i=1:length(beta)-1
   by(i) = ((Y(2)-Y(1))/(xb(i+1)-xb(i))); 
end
by(i+1) = by(i);

%% Assigning the values
W(:) = 0;
for i = 1:ny
    P(i,:) = log(p2(i));
    R(i,:) = log(rho2(i));
    u(i,:) = u2(i);
    v(i,:) = v2(i);
    for j = 1:nx
        C(i,j) = (X(j) - 1) * by(i) - X(j) * cot(beta(i));
    end
    B(i,:) = (u(i,:) - W(i,:).*X(:)' + v(i,:).*C(i,:))/delta(i);
end
S = P - gamma .* R;
end