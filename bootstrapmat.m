function [B,C] = bootstrapmat(A,p)
% Bootstrapmat divides matrix A in two matrices

[iA,jA,kA]=find(tril(A));
kB = binornd(kA,p);
kC=kA-kB;
B=sparse(iA,jA,kB);
B=B+B';
C=sparse(iA,jA,kC);
C=C+C';
end