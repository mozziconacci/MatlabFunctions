function [Cn] = domainogramFnew(Data)

n=length(Data);
Cn=zeros(n,round(n/4));
mat=repmat(Data,2,2);
Cn(:,1)=diag(mat(n:2*n,1:n));
for i=1:round(n/4)-1
       Cn(:,i+1)=Cn(:,i)+diag(mat(n-i:2*n-i,i+1:n+i));
end
%Cn=Cn./repmat(max(Cn),length(Cn),1);
Cn=(Cn-repmat(min(Cn),length(Cn),1))./(repmat(max(Cn),length(Cn),1)-repmat(min(Cn),length(Cn),1));