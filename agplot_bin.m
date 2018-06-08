function [ Agp ] = agplot_bin( A,B, size )
% aggregate a on b bins around size
n=length(A);
Agp=zeros(2*size+1,1);
for i=1:length(B)
    Agp=Agp+A(B(i)-size:B(i)+size);
end
Agp=Agp/length(B);
end

