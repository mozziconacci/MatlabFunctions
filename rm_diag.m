function CBD = rm_diag(CBF,diag)

disp('Remove diagonal')
[i,j,d] = find(CBF);
list = [i,j,d];
list5 = list(abs(list(:,1)-list(:,2))>diag,:);
CBD = sparse(list5(:,1),list5(:,2),list5(:,3));

end