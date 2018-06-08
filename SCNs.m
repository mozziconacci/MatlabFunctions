function [DataFN] = SCNs(DataF)


n1 = length(DataF);

%  normalisation col/ligne 1
DataFN = sparse(n1, n1);
for i=1:1:n1
 DataFN(:,i) = DataF(:,i)./sum(DataF(:,i));
end
for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./sum(DataFN(i,:));
end
%  normalisation col/ligne 2 
for i=1:1:n1
 DataFN(:,i) = DataFN(:,i)./sum(DataFN(:,i));
end

for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./sum(DataFN(i,:));
end

DataFN=(DataFN+DataFN')/2;

end
