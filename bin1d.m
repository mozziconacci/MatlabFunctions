function M = bin1d(Data,p)

%Data = input vector
%p rescaling factor

[i,d] = find(Data);
M=sparse(floor(i/p)+1,ones(length(d),1),d);
M=full(M);
end

