function [CBO,OE] = observed_expected(CBW,scale_max)


%disp('observed/expected')
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
%figure,loglog(OE);


expected(expected(:,1) == 0,1)= 1 ;

for k = 1:md 
  list1(k,3) = list(k,3) / expected( m + list(k,2)-list(k,1) , 1 ) ;
end

CBO = sparse(list1(:,1),list1(:,2),list1(:,3));

end