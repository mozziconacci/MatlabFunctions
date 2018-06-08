
function [A] = despeckele(donnees,t);

[nrow,ncol]=size(donnees);
N = zeros(1,nrow);
C = zeros(1,ncol);

A=donnees;
gauche = donnees ; gauche(:,1) = [] ; gauche = [gauche N'];
droite = donnees ; droite(:,ncol) = [] ; droite = [N' droite] ;
haut = donnees ; haut(1,:) = [] ; haut = [haut;C] ;
bas = donnees ; bas(nrow,:) = [] ; bas = [C;bas] ;

B=(gauche+droite+haut+bas);
A(A*t >= B/4+1)=B(A*t >= B/4+1)/4;

end
