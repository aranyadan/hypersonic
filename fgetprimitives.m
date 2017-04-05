%% Function to extract primitive values
function prim = fgetprimitives(Q)
[ny,nx,~] = size(Q);
R = reshape(Q(:,:,1),ny,nx);
u = reshape(Q(:,:,2),ny,nx);
v = reshape(Q(:,:,3),ny,nx);
P = reshape(Q(:,:,4),ny,nx);
prim = zeros([size(R) 4]);
prim(:,:,:) = reshape([u v exp(P) exp(R)],size(prim));
end