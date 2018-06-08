function [newM] = newmapaftercontact(M,i,j)

newp=max(M(i,:),M(j,:));
p1=sqrt(bsxfun(@times,M,newp));
p2=sqrt(bsxfun(@times,M,newp'));
% p1=bsxfun(@times,M,newp);
% p2=bsxfun(@times,M,newp');

p3=p1';
p4=p2';

temp=cat(3,M,p1,p2,p3,p4);

newM=SCN_sumV2(max(temp,[],3));
%newM=max(temp,[],3);
end

