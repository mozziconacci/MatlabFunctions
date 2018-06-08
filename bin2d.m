function M = bin2d(Data,p,q)

%Data = input matrix
%p,q rescaling factors
[n]=length(Data);

[i,j,d] = find(Data);
M=sparse(floor(i/p)+1,floor(j/q)+1,d,floor(n/p)+1,floor(n/p)+1);

if p==1
    M=M(2:end,:);
end
if q==1
    M=M(:,2:end);
end
end

