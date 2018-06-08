% enrich1bis

function [A] = enrich1bis(donnees);

n=length(donnees);
s = [0 1 0;1 2 1;0 1 0];
donnees(donnees>1) = 1 ;
A = conv2(s,donnees);
A = A(2:end-1,2:end-1);
%A(A>1) = 1 ;

end
