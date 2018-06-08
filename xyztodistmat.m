
function [distmat] = xyztodistmat(data)

n=length(data);
distmat= zeros(n,n);
for i=1:n
    for j=1:n
        distmat(i,j)=sqrt(sum((data(i,:)-data(j,:)).*(data(i,:)-data(j,:))));
    end
end


        
