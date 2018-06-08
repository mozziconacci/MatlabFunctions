function binmat = bin1dfast(mat,bin)

sizemat = size(mat);
sizecond=sizemat(1);
sizegen=sizemat(2);

binmat=zeros(sizecond,bin);

parfor i =[1:sizecond]
binmati = zeros(bin,1);
mati = mat(i,:);
for j=[1:sizegen]
idx=floor(j*bin/sizegen)+1;
if idx>bin
idx=bin;
end
binmati(idx) = binmati(idx) + mati(j);
end
i
binmat(i,:) = binmati;
end


end