function [W] = knn_graph(X, k)
% This function creates the k-nearest neighborhood similarity graph and its adjacency matrix W
% X is the matrix whose graph needs to be computed
% k is the number of neighborhoods
% threshold is the minimum similarity value required for a connection
    
threshold=0.001;
sigma = 1; 
N = size(X, 1); 
W = zeros(N, N);
    
    for i = 1:N
        [idx, dist] = knn_search(X, X(i, :), k); % includes itselfs
        
        for j = 2:k
            similarity = exp(-dist(j)^2 / (2 * sigma^2));
            
            % Set similarity to zero if it is below the threshold
            if similarity < threshold
                similarity = 0;
            end
            
            W(i, idx(j)) = similarity;
            W(idx(j), i) = similarity;
        end
    end
    
    if sum(diag(W)) ~= 0
        error("W has not all zeros on the main diagonal")        
    end
end


