function [DataFN] = SCN_std(Data)


[n1,p1] = size(Data)

DataN = zeros(n1, p1);
normes = zeros(n1, 1);

for i=1:1:n1
normes(i) = std(Data(:,i));
end

figure, hist(normes(:),100)

DataF=Data(normes(:) > 0, :);
DataF=DataF(:, normes(:) > 0);

[n1,p1] = size(DataF)
normes = zeros(n1, 1);



%  normalisation col/ligne 1
DataFN = zeros(n1, p1);
for i=1:1:n1
 DataFN(:,i) = DataF(:,i)./std(DataF(:,i));
end
for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./std(DataFN(i,:));
end
%  normalisation col/ligne 2 
for i=1:1:n1
 DataFN(:,i) = DataFN(:,i)./std(DataFN(:,i));
end

for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./std(DataFN(i,:));
end

%  normalisation col/ligne 3
for i=1:1:n1
 DataFN(:,i) = DataFN(:,i)./std(DataFN(:,i));
end
for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./std(DataFN(i,:));
end
%  normalisation col/ligne 4
for i=1:1:n1
 DataFN(:,i) = DataFN(:,i)./std(DataFN(:,i));
end
for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./std(DataFN(i,:));
end

end
