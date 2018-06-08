function [MM] = distmattoGram(Data)

n=length(Data);

% compute distance to center
center=zeros(n,1);
for i=1:n
    for j=1:n
    center(i)=center(i)+Data(i,j)^2-1/n*(Data(j,j:n)*Data(j:n,j));
    end
end

center(center<0)=0;
center=sqrt(center/n);
% conpute Gram matrix

MM=1/2*(repmat(center.*center,1,n)+repmat((center.*center)',n,1)-Data.*Data);

end
