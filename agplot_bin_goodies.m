function [ Agp,goodies] = agplot_bin_goodies( A,B, size )
% aggregate a on b bins around size
n=length(A);
Agp=zeros(2*size+1,1);
goodies=zeros(2*size+1,length(B));
for i=1:length(B)
    Agp=Agp+A(B(i)-size:B(i)+size);
    goodies(:,i)=A(B(i)-size:B(i)+size);
end
Agp=Agp/length(B);
goodies=goodies';
figure, imagesc(goodies);
end

