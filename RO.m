function [ ROv ] = RO(a,b)
%gives relative overlap
select=find(a~=0 | b~=0);
a=a(select);
b=b(select);
ROv=sum(a==b)./min(sum(a>0),sum(b>0));

end

