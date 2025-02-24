function [num_connected_components, eigenvectors, eigenvalues] = num_connect_comp(L,tol)
% The number of connected components in the graph corresponds to the number of zero eigenvalues of L.
% Number of connected components= multiplicity of eigenvalue 0

n=20; % number of eigenvalues to be computed

[eigenvectors, eigenvalues] = deflation(L,n);
num_connected_components = sum(abs(diag(eigenvalues))<tol);

end

