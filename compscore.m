function [S,SM,SMM] = compscore( G )
%comp score computes the compscore S of a graph G
C=conncomp(G);
for i=1:max(C)
CC(i)=sum(C==i);
end


Gedges=adj2edgeL(adjacency(G));
Gedges(:,2)=randswap(Gedges(:,2));
temp=edgeL2adj(Gedges);
Gr=graph(temp+temp');
Cr=conncomp(Gr);
for i=1:max(Cr)
CCr(i)=sum(Cr==i);
end
S=max(CC)/max(CCr);
SM=sum(CC.^2)/sum(CCr.^2);
SMM=sum(CC.^3)/sum(CCr.^3);
end


