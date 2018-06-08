function [DMAT] = GramtoDMATndim(distmat,n)

[V,D]=eigs(distmat,n);
lambda=diag(D);
figure,plot(lambda);
select=lambda>0;
out=sqrt(repmat(lambda(select),1,length(V(:,select)))).*V(:,select)';
DMAT=distance(out,out);

end
