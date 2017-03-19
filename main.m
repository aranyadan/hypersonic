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

yc=0:dy:(ny-1)*dy;
xs = (yc).^2;
xb = xbody + (yc+1).^3;
dx = xbody/(nx-1);

x=zeros(ny,nx);
y=x;

if(DISPLAYMESH==1)
    hold on;
    grid on;
    box on;
    plot(xs,yc);
    plot(xb,yc);
end
for i=1:ny
    y(i,:) = yc(i);
    dx = (xb(i) - xs(i))/(nx-1);
    x(i,:) = xs(i):dx:xb(i);
    if(DISPLAYMESH==1)
        scatter(x(i,:),y(i,:));
    end
end

%% Transforming the coordinates into X,Y

X=zeros(nx);
Y=yc;
dX = (x(1,2) - x(1,1))/(xb(1)-xs(1));
X=0:dX:(nx-1)*dX;

%% Set Initial Conditions
[R,u,v,S,P,B,W,C] = fIC(X,Y,xs,xb);

%% Solver LOOP
nt=100;
for t=1:nt
    
end