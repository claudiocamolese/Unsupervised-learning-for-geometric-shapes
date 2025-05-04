clc
close all
clear

rng(42)


datasets = {'Dataset 1 (Circle.mat)', 'Dataset 2 (Spiral.mat)', 'Dataset 3 (3D.mat)'};

[choice, ok] = listdlg('PromptString', 'Select a dataset:', ...
                          'SelectionMode', 'single', ...
                          'ListString', datasets, ...
                          'ListSize', [250, 250], ...
                          'Name', 'Dataset Selection', ...
                          'OKString', 'Select', ...
                          'CancelString', 'Cancel');

if ok
    switch choice
        case 1
            load('Circle.mat');
            flag=false;
            db=false;
            tolerances_L=[1e-2,1e-1,1e-1];
            tolerances_Lsym=[1e-3,0.8e-2,1e-2];
        case 2
            load('Spiral.mat');
            flag=false;
            db=true;
            tolerances_L=[1e-3,1e-3,1e-3];
            tolerances_Lsym=[1e-3,1e-3,1e-3];
            
        case 3
            load('three_spheres_3D.mat');
            X=spheres;
            flag=true;
            db=true;
            tolerances_L=[1e-3,1e-3,1e-2];
            tolerances_Lsym=[1e-3,0.8e-3,1e-3];
    end
    disp('Dataset loaded!');
else
    disp('Operazione annullata.');
end

laplacian_options = {'L (Standard Laplacian)', 'Lsym (Symmetric Laplacian)'};
[laplacian_choice, laplacian_ok] = listdlg('PromptString', 'Select the Laplacian type:', ...
                                           'SelectionMode', 'single', ...
                                           'ListString', laplacian_options, ...
                                           'ListSize', [250, 250], ...
                                           'Name', 'Laplacian Selection', ...
                                           'OKString', 'Select', ...
                                           'CancelString','Cancel');


k_values = [10,20,40];
num_connected_components=zeros(size(k_values,2),1);
i=1;

for k = k_values

    W= knn_graph(X,k);

    [L,D,W]= LDW(W);

    Lsym= compute_Lsym(L,D);

    if laplacian_ok
        if laplacian_choice == 2
            L = Lsym;
            tol=tolerances_Lsym(i);
        else
            tol=tolerances_L(i);
        end
    else
        disp('Operation cancelled.');
        return;
    end

    [num_connected_components(i),eigenvectors, eigenvalues]= num_connect_comp(L,tol);
    
    U=eigenvectors(:,1:num_connected_components(i)); 

    [cluster_labels, cluster_centers] = k_means(U,num_connected_components(i));


    % Plots
    
    figure
    subplot(2,2,1)
    plot(linspace(1,20,20), diag(eigenvalues), MarkerIndices=6)
    hold on;
    plot(linspace(1,20,20), diag(eigenvalues), 'ro', 'MarkerFaceColor', 'w');  
    xlabel('Index');
    ylabel('Value');
    grid on
    title(sprintf("eigenvalues k=%g", k))

    subplot(2,2,2)
    plot(linspace(1,20,20), diag(eigenvalues)/max(diag(eigenvalues)), MarkerIndices=6)
    hold on;
    plot(linspace(1,20,20), diag(eigenvalues)/max(diag(eigenvalues)), 'ro', 'MarkerFaceColor', 'w');  
    xlabel('Index');
    ylabel('Value %');
    grid on
    titolo=sprintf("Eigenvalues as percentages  k=%g", k);
    title(titolo)

    subplot(2,2,3)
    spy(W)
    titolo=sprintf("Adjacency Matrix (W)");
    title(titolo)
    
    if choice == 3
        subplot(2,2,4)
        scatter3(spheres(:,1), spheres(:,2), spheres(:, 3), 10, cluster_labels, "filled")
        titolo=sprintf("Sphere clustered with k=%g", k);
        title(titolo)
    else
        subplot(2,2,4)
        gscatter(X(:,1), X(:,2), cluster_labels, "rgb")
        titolo=sprintf("Dataset clustered with k=%g", k);
        title(titolo)
    end 

    i=i+1;

    disp(['Finished with k=', num2str(k)])

    other_cluster(X,k,flag,db)

end



