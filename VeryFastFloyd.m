







function D = VeryFastFloyd(D)

	n = size(D, 1);	

	for k=1:n
        %clear('i2k');
        %clear('j2j');
		i2k = repmat(D(k:n,k), 1, n-k+1);
		k2j = repmat(D(k,k:n), n-k+1, 1);
		D(k:n,k:n) = min(D(k:n,k:n) , i2k+k2j);
	
    end
  
    

    
end