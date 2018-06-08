function [OE] = p_de_s(CBW,scale_max)

[m,n] = size(CBW);
[i,j,d] = find(CBW);
list = [i,j,d];

list = list((list(:,1) - scale_max < list(:,2)) & (list(:,2) < list(:,1) + scale_max),:);
[md,nd] = size(list(:,3));
d_zeros = zeros(md,1);
list1 = [list(:,1),list(:,2),d_zeros];

expected = zeros(2*m+1,1);
for k = 1:md
  expected( (m + list(k,2) - list(k,1) ) ,1 ) = expected( (m  + list(k,2) - list(k,1)) ,1 ) + list(k,3);
end

tri=[1:m,m,m:-1:1];
expected=expected./tri';
OE=expected(m:m+scale_max);


end