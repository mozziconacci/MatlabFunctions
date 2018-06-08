function tab = set_normalisation(mat,scale_max)

tab=zeros(scale_max,2);

[m,n] = size(mat);

if scale_max>m
    scale_max = m;
end

[i,j,d] = find(mat);
list = [i,j,d];

list = list((list(:,1) < list(:,2)) & (list(:,2) < list(:,1) + scale_max),:);
[md,nd] = size(list(:,3));

% d_zeros = zeros(md,1);
% list1 = [list(:,1),list(:,2),d_zeros];

num_0 = zeros(m,1);
num_1 = zeros(m,1);
value_diag = zeros(m,1);

for k = 1:md
  value_diag( (list(k,2) - list(k,1) ) ,1 ) = value_diag( (list(k,2) - list(k,1)) ,1 ) + list(k,3);
  num_1( (list(k,2) - list(k,1) ) ,1 ) = num_1( (list(k,2) - list(k,1)) ,1 ) + 1;
end

for d= 1:scale_max
    if num_1(d,1)>0
        num_0(d,1) = (m-(d-1)) - num_1(d,1); 
        
        %Fill the tab
        tab(d,1)=1/(sqrt(2)*value_diag(d,1));
        tab(d,2)=-1/(sqrt(2)*num_0(d,1));
    else
        %Fill the tab
        tab(d,1)=0;
        tab(d,2)=0;
        
    end
end

% for k = 1:md 
%   list1(k,3) = tab(list(k,2)-list(k,1) , 1 ) ;
% end
% 
% CBO = sparse(list1(:,1),list1(:,2),list1(:,3));

end