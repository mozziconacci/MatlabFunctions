function [Cn,count] = domainogram_count(Data)

n=length(Data);
Cn=zeros(n,round(n/2));
count=zeros(round(n/2),1);
mat=repmat(Data,2,2);
Cn(:,1)=smoothsig(diag(mat(n:2*n,1:n))',10)';
for i=1:round(n/2)-1
       Cn(:,i+1)=Cn(:,i)+smoothsig(diag(mat(n-i:2*n-i,i+1:n+i))',10)';
       count(i)=length(extrema(Cn(:,i+1)))/2;
end
%Cn=Cn./repmat(max(Cn),length(Cn),1);
Cn=(Cn-repmat(min(Cn),length(Cn),1))./(repmat(max(Cn),length(Cn),1)-repmat(min(Cn),length(Cn),1));