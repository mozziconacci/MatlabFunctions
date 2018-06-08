function [DataFN] = SCN_sum(Data,seuilmin,seuilmax)


[n1,p1] = size(Data)

DataN = zeros(n1, p1);
sumes = zeros(n1, 1);

for i=1:1:n1
sumes(i) = sum(Data(:,i));
end

figure, hist(sumes(:),100)

DataF=Data(sumes(:) > seuilmin & sumes(:) < seuilmax, :);
DataF=DataF(:, sumes(:) > seuilmin  & sumes(:) < seuilmax);

[n1,p1] = size(DataF)
sumes = zeros(n1, 1);



%  sumalisation col/ligne 1
DataFN = zeros(n1, p1);
for i=1:1:n1
 DataFN(:,i) = DataF(:,i)./sum(DataF(:,i));
end
for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./sum(DataFN(i,:));
end
%  sumalisation col/ligne 2 
for i=1:1:n1
 DataFN(:,i) = DataFN(:,i)./sum(DataFN(:,i));
end

for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./sum(DataFN(i,:));
end

%  sumalisation col/ligne 3
for i=1:1:n1
 DataFN(:,i) = DataFN(:,i)./sum(DataFN(:,i));
end
for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./sum(DataFN(i,:));
end
%  sumalisation col/ligne 4
for i=1:1:n1
 DataFN(:,i) = DataFN(:,i)./sum(DataFN(:,i));
end
for i=1:1:n1
 DataFN(i,:) = DataFN(i,:)./sum(DataFN(i,:));
end

DataFN=(DataFN+DataFN')/2;

end
