
function [distmat] = xyztoGram(data)

n=length(data);
distmat= zeros(n,n);
center=sum(data,1)/n;
for i=1:n
    for j=1:n
        distmat(i,j)=(data(i,:)-center)*(data(j,:)-center)';
    end
end

figure, imagesc(-distmat);
        
