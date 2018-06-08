function [DataFN] = SCN_sumVtest(DataF)


DataFN = spdiags(spfun(@(x) 1./x,sum(DataF,2)),0,size(DataF,1),size(DataF,1))*DataF;
DataFN = spdiags(spfun(@(x) 1./x,sum(DataFN',2)),0,size(DataFN',1),size(DataFN',1))*DataFN';

%Remove nan and infs
DataFN(isnan(DataFN))=0;
DataFN(isinf(DataFN))=0;


end
