% enrich1

function [A] = enrich1(donnees);

[nrow,ncol]=size(donnees);
N = zeros(1,nrow);
C = zeros(1,ncol);

A=donnees;
gauche = donnees ; gauche(:,1) = [] ; gauche = [gauche N'];
droite = donnees ; droite(:,ncol) = [] ; droite = [N' droite] ;
haut = donnees ; haut(1,:) = [] ; haut = [haut;C] ;
bas = donnees ; bas(nrow,:) = [] ; bas = [C;bas] ;
A=A+gauche+droite+haut+bas;
% A(A>1) = 1 ;

end
