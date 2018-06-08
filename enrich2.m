% enrich2

function [A] = enrich2(donnees);

donnees2 = donnees*donnees ;
A = donnees+donnees2 ; 
clear('donnees2');

%A(A>1) = 1 ;
end
