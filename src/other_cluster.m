function other_cluster(X, k,flag,db)
    
     if k==10  
      figure('Position', [100, 100, 1000, 500]); 
    
        if flag==true
            subplot(1,1,1);
            db_cluster = dbscan(X, 2.7, k);
            scatter3(X(:,1), X(:,2), X(:,3), 30, db_cluster, 'filled');
            title(sprintf('DBSCAN Clustering with k=%g', k));
        else
            subplot(1,1,1);
    
            if db==true
                db_cluster = dbscan(X, 1,k,"Distance","seuclidean");
            else
                db_cluster = dbscan(X, 0.8,k);
            end
    
            cmap = lines(max(db_cluster)+1); % Generates a distinct color for each cluster
            gscatter(X(:,1), X(:,2), db_cluster, cmap,".",  12)
            titolo = sprintf('DBSCAN Clustering with k=%g', k);
            title(titolo);
        end
    end
end 