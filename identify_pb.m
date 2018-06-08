
function [A] = identify_pb(donnees);

[nrow,ncol]=size(donnees);
[x,y,k]=find(donnees);

A=zeros(ncol,1);

for i=1:100;
    i
    A(i)=mean(abs(x(y==i)-y(y==i)).*k(y==i));
end

figure, plot(A);

end
