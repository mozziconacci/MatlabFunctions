function [newM] = newmapaftercontact2(M,i,j)

newp=max(M(i,:),M(j,:));

M(i,:)=newp;
M(:,i)=newp;
M(j,:)=newp;
M(:,j)=newp;

M=SCN_sumV2(M);

temp=completemap(M,2);

newM=SCN_sumV2(temp);
%newM=max(temp,[],3);
end

