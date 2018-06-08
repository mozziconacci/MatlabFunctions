function [newM] = completemap(M,s)

distmat=FastFloyd(1./M.^s);
newM=1./distmat.^(1/s);

end

