
function [B] = intra(donnees,chr);

[nrow,ncol]=size(donnees);
[i,j,k]=find(donnees); 
A=sparse(i(chr(i)==chr(j)),j(chr(i)==chr(j)),k(chr(i)==chr(j)));
B=sparse(nrow,ncol);
B(1:length(A),1:length(A))=A;

end
