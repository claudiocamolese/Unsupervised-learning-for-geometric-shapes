function Lsym= compute_Lsym(L,D)

D_inv_sqrt = spdiags(1 ./ sqrt(diag(D)), 0, size(D, 1), size(D, 2));
Lsym = D_inv_sqrt * L * D_inv_sqrt;

end

