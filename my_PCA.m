function [PC1,PC2] = my_PCA(comparemat,name)
% Plot the two dimensional PCA

corrmat=corrcoef(comparemat);
[V,D]=eig(corrmat);
figure, 
hold on,
plot(V(:,end),V(:,end-1),'.r');
labelpoints(V(:,end),V(:,end-1),name);
title('PCA of the distance matrix')
VP=diag(D);
PC1=VP(end)/sum(VP)
PC2=VP(end-1)/sum(VP)
ylabel(sprintf('PC2(%d %%)',round(PC2*100)))
xlabel(sprintf('PC1(%d %%)',round(PC1*100)))
title('Principal Component Analysis (PCA)')

end

