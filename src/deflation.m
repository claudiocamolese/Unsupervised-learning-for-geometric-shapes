function [eigenvectors, eigenvalues] = deflation(A, num_eigenvalues)
% This function compute the first smallest n eigenpairs using the
% inverse power method function.
% The outputs are a diagonal matrix of eigenvalues and a matrix of
% eigenvectors

% cell function is used to store efficiently a matrix in the memory
    
    [n, m] = size(A);

    if n ~= m
        error("The matrix must be square");
    end
    
    eigenvalues = zeros(num_eigenvalues, num_eigenvalues);
    eigenvectors = zeros(n, num_eigenvalues);
    beta = zeros(n, n);
    
    % Store only the necessary submatrices for P_bars, cell to allocate more efficient
    P_bars = cell(num_eigenvalues, 1);
    
    compute_P_ = @(v,e,n) eye(n)-2*(((v+e)*(v+e)')/norm(v+e)^2);
    
    for k = 1:num_eigenvalues
        [v_bar, l] = inverse_power_method(A);
        eigenvalues(k,k) = l;
        
        if k == 1
            eigenvectors(:,k) = v_bar;
        else
            for j = 1:k-1
                if eigenvalues(j,j) >= eigenvalues(k,k)
                    eigenvalues(k,k) = eigenvalues(k,k) + 1e-4;
                end
            end
        end
        
        e = zeros(n-k+1, 1);
        e(1) = 1;
        P_bar = compute_P_(v_bar, e, n-k+1);
        P_bars{k} = P_bar; % Store only the submatrix
        P = blkdiag(eye(k-1), P_bar);
        
        if k == 1
            B = P*A*P;
        else
            B = P*B*P;
        end
        
        b = B(k,k+1:end);
        beta(k, 1:length(b)) = b;
        
        if k > 1
            coeff = -beta(k-1, 1:n-k+1)*v_bar/(eigenvalues(k-1,k-1)-eigenvalues(k,k));
            v_bar = [coeff;v_bar];
            
            for j = k:-1:3
                coeff = -beta(j-2,1:n-j+2)*P_bars{j-1}*v_bar/(eigenvalues(j-2,j-2)-eigenvalues(k,k));
                v_bar = [coeff;v_bar];
            end
            
            v = v_bar;
            
            for c = k-1:-1:1
                P = blkdiag(eye(c-1), P_bars{c});
                v = P*v;
            end

            eigenvectors(:,k) = v;
        end
        
        A = B(k+1:end, k+1:end);
    end
end