function [indices, distances] = knn_search(X, point, k)
% finds the k-nearest neighbors of a query point within the dataset X.

    if k <= 0 || k > size(X, 1)
        error('k must be a positive integer less than or equal to the number of data points in X.');
    end

    N = size(X, 1);
    distances = zeros(N, 1);
    
    for i = 1:N
        distances(i) = norm(X(i, :) - point); 
    end

    [sortedDistances, sortedIndices] = sort(distances);

    % Return the top k neighbors
    indices = sortedIndices(1:k);
    distances = sortedDistances(1:k);
end
