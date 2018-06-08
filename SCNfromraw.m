function [matrixN,chrF,tRNAF] = SCNfromraw(matrix1,chr,tRNA)

%filter
summat=sum(matrix1);
meansum=mean(summat);
stdsum=std(summat);

if (meansum < 1.5*stdsum)
    disp('filtering problem');
    meansum=2*stdsum;
end

trash=(summat > meansum+1.5*stdsum | meansum-1.5*stdsum>summat);

matrixF=matrix1(trash==0,trash==0,:);
chrF=chr(trash==0);
tRNAF=tRNA(trash==0);

%Despeckele
seuil=0.2;
matrixF=despeckele(matrixF,seuil);

%On enlève la diago
matrixF=matrixF-diag(diag(matrixF));

%Renormalisation des matrices
matrixF=matrixF/sum(sum(matrixF));

%SCN
matrixN=SCN_sumV2(matrixF);

end
