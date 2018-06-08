function [out] = pdbfromraw(matrix,chr)

%filter
summat=sum(matrix);
meansum=mean(matrix);
stdsum=std(matrix);


trash=(summat > meansum+1.5*stdsum | meansum-1.5*stdsum>summat);

matrixF=matrix(trash==0,trash==0,:);
chrF=chr(trash==0);


%Despeckele
seuil=0.2;
matrixF=despeckele(matrixF,seuil);

%On enlève la diago
matrixF=matrixF-diag(diag(matrixF));

%Renormalisation des matrices
matrixF=matrixF/sum(sum(matrixF));

%SCN
matrixN=SCN_sumV2(matrixF);

exp=1;

ff=FastFloyd(1./matrixN.^exp);      
Gram=distmattoGram(ff);
XYZ=GramtoXYZ(Gram);
[pts, V]= convhulln(XYZ);
scale=100/V^(1/3);
XYZ=XYZ*scale;





end
