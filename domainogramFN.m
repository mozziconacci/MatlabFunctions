function [Cn] = domainogramFN(Data)

n=length(Data);
Cn=zeros(n,round(n/10));
mat=repmat(Data,2,2);
Cn(:,1)=diag(mat(n:2*n,1:n))/max(diag(mat(n:2*n,1:n)));
for i=1:round(n/10)-1
       Cn(:,i+1)=Cn(:,i)+diag(mat(n-i:2*n-i,i+1:n+i))/max(diag(mat(n-i:2*n-i,i+1:n+i)));
end
figure, imagesc(Cn');
