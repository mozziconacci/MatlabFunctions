function M = PdeS(Data)

%Data = input matrix
%p,q rescaling factors

n=length(Data);
M=zeros(n,1);
for i=1:n
    M(i)=sum(diag(Data,i))/length(diag(Data,i));
end

end

