function [DataFN] = SCN(Data,seuil)


[n1,p1] = size(Data)

DataN = zeros(n1, p1);
normes = zeros(n1, 1);

for i=1:1:n1
normes(i) = norm(Data(:,i));
end

figure, hist(normes(:),100)

DataF=Data(normes(:) > seuil, :);
DataF=DataF(:, normes(:) > seuil);

[n1,p1] = size(DataF)
normes = zeros(n1, 1);



%  normalisation col/ligne 1
DataFN = zeros(n1, p1);
for i=1:1:n1
 DataFN(:,i) = DataF(:,i)./norm(DataF(:,i));
end
for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./norm(DataFN(i,:));
end
%  normalisation col/ligne 2 
for i=1:1:n1
 DataFN(:,i) = DataFN(:,i)./norm(DataFN(:,i));
end

for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./norm(DataFN(i,:));
end

%  normalisation col/ligne 3
for i=1:1:n1
 DataFN(:,i) = DataFN(:,i)./norm(DataFN(:,i));
end
for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./norm(DataFN(i,:));
end
%  normalisation col/ligne 4
for i=1:1:n1
 DataFN(:,i) = DataFN(:,i)./norm(DataFN(:,i));
end
for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./norm(DataFN(i,:));
end

DataFN=(DataFN+DataFN')/2;

end
