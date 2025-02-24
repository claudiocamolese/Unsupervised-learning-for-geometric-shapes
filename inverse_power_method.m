function [v1,lambda_j] = inverse_power_method(A)
% inverse power method computes the smallest eigenpair of a matrix.
% shift is use to avoid ill conditioning computations and because we want 
% to explore eigenvalues close to zero the shift is near to zero

tol=1e-6;
maxIter=1000;
n = size(A, 1);
x0=randn(n,1);
p=1e-12;

M = A - p * eye(n);
xk = x0 / norm(x0); 
sigma_prev = 0;

for k = 1:maxIter
   
    yk = M \ xk;

    xk_next = yk / norm(yk);

    sigma_k=  (yk' * xk) ;

    if abs(sigma_k - sigma_prev) < tol
        break;
    end

    xk = xk_next;
    sigma_prev = sigma_k;
end

sigma_1 = sigma_k; 
v1 = xk_next;      
lambda_j = 1 / sigma_1 + p; 

end