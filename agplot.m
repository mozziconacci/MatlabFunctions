function [ Agp ] = agplot( A,B, size )
% aggregate a on b around size
n=length(A);
Agp=zeros(2*size+1,1);
for i=size+1:n-size
    Agp=Agp+B(i).*A(i-size:i+size);
end
Agp=Agp/((n-length(Agp)))-mean(A)*mean(B);
end

