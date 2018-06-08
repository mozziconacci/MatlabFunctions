function [out] = Gramtorecurplot(distmat)

[V,D]=eigs(distmat,4);
lambda=diag(D);
out=[V(:,1)*sqrt(lambda(1)) V(:,2)*sqrt(lambda(2)) V(:,3)*sqrt(lambda(3))];

%figure, plot3(V(:,1)*sqrt(lambda(1)),V(:,2)*sqrt(lambda(2)),V(:,3)*sqrt(lambda(3)));

end
