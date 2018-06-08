function [DataFN] = SCN_Capture(DataF)

n=length(DataF);
[t,v]=observed_expected(DataF,n);
tN=SCN_sumV2(t);
DataFN=zeros(n);

for i=1:n-1
DataFN=DataFN+diag(diag(DataF,i).*t(i),i);
end

DataFN=DataFN+DataFN';
%Remove nan and infs
DataFN(isnan(DataFN))=0;
DataFN(isinf(DataFN))=0;

%RE-SYMETRIZED

DataFN=(DataFN+DataFN')/2;

end
