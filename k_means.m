function [best_cluster_labels, best_cluster_centers] = k_means(data, k)
 
    
    [n_points, ~] = size(data);
    max_iter = 100; 
    num_initializations = 20;

    best_silhouette_score = -Inf;
    best_cluster_labels = [];
    best_cluster_centers = [];

    for init = 1:num_initializations
        
        rng("shuffle"); 
        % randomly selects k data points from the dataset to be the initial cluster centers.
        random_indices = randperm(n_points, k); 
        cluster_centers = data(random_indices, :);

        prev_labels = zeros(n_points, 1);
        cluster_labels = zeros(n_points, 1);

        iter = 0;
        has_converged = false;

        while ~has_converged && iter < max_iter
            
            for i = 1:n_points
                distances = zeros(k, 1);
                for j = 1:k
                    diff = data(i, :) - cluster_centers(j, :); % distance from the centroids of all the points
                    distances(j) = sqrt(sum(diff.^2)); % euclidian distance
                end
                [~, cluster_labels(i)] = min(distances);
            end

       
            for j = 1:k
                cluster_points = data(cluster_labels == j, :);
                if ~isempty(cluster_points)
                    % the cluster centers are updated by computing the mean of the points assigned to each cluster.
                    cluster_centers(j, :) = mean(cluster_points, 1); 
                end
            end

            has_converged = isequal(prev_labels, cluster_labels); % check if labels have changed
            prev_labels = cluster_labels; % update previous labels
            iter = iter + 1;
        end

        silhouette_scores = silhouette(data, cluster_labels);
        mean_silhouette_score = mean(silhouette_scores);

        % Save best result
        if mean_silhouette_score > best_silhouette_score
            best_silhouette_score = mean_silhouette_score;
            best_cluster_labels = cluster_labels;
            best_cluster_centers = cluster_centers;
        end
    end

end
