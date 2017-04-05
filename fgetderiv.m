%% Function to calculate dQ/dt

function dQ = fgetderiv(dQX,dQY,B,delta,C,prim)
dQ = zeros(size(dQX));
[ny, nx, ~] = size(dQX);
for i=1:ny
    for j = 1:nx
        % Calculate the Jacobians
        [A1,A2] = fJacobians(B(i,j),delta(i),C(i,j),prim(i,j,:));
        dQ(i,j,:) = A1 * reshape(dQX(i,j,:),5,1) + A2 * reshape(dQY(i,j,:),5,1);
    end
end
end