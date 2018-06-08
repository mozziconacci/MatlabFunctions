function matbin = Bin1dfast(mat,bin)

[N,M] = size(mat);

MB = ceil(M/bin);

matbin = zeros(N,MB);

for i=1:N
   
    matbini = zeros(M,1);
    mati = mat(i,:);
    parfor j=1:MB
				if j*bin<=M
					matbini(j) = sum(mati((j-1)*bin + 1 : j*bin));
        else
					matbini(j) = sum(mati((j-1)*bin + 1 : end));
        end
        
    end
    
    matbin(i,:) = matbini;
    
end


end