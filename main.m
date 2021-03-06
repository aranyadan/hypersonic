%% Solving for flow over a blunt body

%% Setting body shape
% Body is parabola, x=y^3
% Assumed shock is, x=y^2
DISPLAYMESH = 1;
nx = 11;
ny = 21;
yend = 2;
xbody = 5;
dy = yend/(ny-1);
gamma = 1.4;
yc=0:dy:(ny-1)*dy;
xs0 = (yc).^2;
xb = xbody + (yc+1).^3;
dx = xbody/(nx-1);

x=zeros(ny,nx);
y=x;

if(DISPLAYMESH==1)
    hold on;
    grid on;
    box on;
    plot(xs0,yc);
    plot(xb,yc);
end
for i=1:ny
    y(i,:) = yc(i);
    dx = (xb(i) - xs0(i))/(nx-1);
    x(i,:) = xs0(i):dx:xb(i);
    if(DISPLAYMESH==1)
        scatter(x(i,:),y(i,:));
    end
end

%% Transforming the coordinates into X,Y

% X=zeros(nx);
Y=yc;
dX = (x(1,2) - x(1,1))/(xb(1)-xs0(1));
X=0:dX:(nx-1)*dX;
dY = dy;
%% Set Initial Conditions
[R0,u0,v0,S0,P0,B0,W0,C0] = fIC(X,Y,xs0,xb);
R=R0; u=u0; v=v0; S=S0; P=P0; B=B0; W=W0; C=C0;

%% Solver LOOP
nt=100;
% Eqn is written as dQ/dt = A1 * dQ/dX + A2 * dQ/dY
Q = zeros(ny,nx,5); dt=0.01;
Q(:,:,:) = reshape([R u v P S],ny,nx,5);        % Stores the variables
Q0 = Q;
xs = xs0;                                       % Stores iterative shock shape
prim = fgetprimitives(Q);                 % 1-u, 2-v, 3-p, 4-rho
delta = xb-xs;
A1 = zeros(5); A2 = A1;
for t=1:nt
    dQXp = (circshift(Q,[0 -1 0]) - Q)./dX;
    dQYp = (circshift(Q,[-1 0 0]) - Q)./dY;
    
    % Predictor Step
    dQdt1 = fgetderiv(dQXp,dQYp,B,delta,C,prim);
    Q2 = Q - dt.*dQdt1;
    prim2 = fgetprimitives(Q2);
    
    
    dQ2Xp = (Q2 - circshift(Q2,[0 1 0]))./dX;
    dQ2Yp = (Q2 - circshift(Q2,[1 0 0]))./dY;
    % corrector step
    dQdt2 = fgetderiv(dQ2Xp,dQ2Yp,B,delta,C,prim2);
    
    % Actual
    dQdt = 0.5*(dQdt1+dQdt2);
    
    % Update
    Q = Q - dt * dQdt;    
    
end