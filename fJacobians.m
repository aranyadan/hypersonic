%% Function to set the Jacobian values, A1,A2

function [A1,A2] = fJacobians(B,d,C,prim)
%     A1 = zeros(5); A2 = A1;
    v = prim(2);
    p = prim(3);
    rho = prim(4);
    
 %        R    u      v      P                S   
    A1 = [B    1/d    C/d    0                0
          0    B      0      p/(rho*d)        0
          0    0      B      (p*C)/(rho*d)    0
          0    0      0      0                0
          0    0      0      0                B];
      
   A2 =  [v    0      1      0                0
          0    v      0      0                0
          0    0      v      p/rho            0
          0    0      0      0                0
          0    0      0      0                v];
end