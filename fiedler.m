function [f,lam2] = fiedler(A,tol)
% FIEDLER Compute the fiedler vector
%
% [f,lam2] = fiedler(A) finds the Fiedler vector f
% associated with an adjacency matrix A and the 
% second smallest eigenvalue of A, lam2
%
% ... = fiedler(A,tol) controls the tolerance
% in the eigs solver.

if nargin<2,
    tol = eps(1);
end

L = -A+diag(sum(A));
n = size(A,1);
[V,D] = eigs(L,2,'SA',struct('tol',tol));
lam1 = D(1,1);
if abs(lam1) > 100*eps
    warning('fiedler:irregularOutput',...
        ['the matrix has a first eigenvalue with large magnitude: %e. ' ...
        'Check your input.'],...
        abs(lam1));
end
lam2 = D(2,2);
f = V(:,2);