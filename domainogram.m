function [Cn] = domainogram(Data)

n=length(Data);
Cn=zeros(round(n/2),n);
mat=repmat(Data,2,2);
for i=1:round(n/2)
    for j=round(n/2):n+round(n/2)-1
       Cn(i,j-round(n/2)+1)=sum(sum(mat(j:j+i,j:j+i)));
    end
end
dom=dom./repmat(max(dom),length(dom),1);