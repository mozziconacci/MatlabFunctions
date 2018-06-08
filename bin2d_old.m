function M = bin2d_old(Data,p,q)

%Data = input matrix
%p,q rescaling factors

[m,n]=size(Data); %M is the original matrix
mm=floor(m/p);
nn=floor(n/q);
M=Data(1:p*mm,1:q*nn);
[m,n]=size(M);
M=sum( reshape(M,p,[]) ,1 );
M=reshape(M,m/p,[]).'; %Note transpose
%figure, imagesc(M)
M=sum( reshape(M,q,[]) ,1);
M=reshape(M,n/q,[]).'; %Note transpose
%figure, imagesc(M)

end

