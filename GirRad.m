function [gr] = GirRad(xyz)
% computes raduis of giration of 3D points
n=length(xyz);
xyz_zero=mean(xyz);
gr=(1/n)*sum(sum((xyz-repmat(xyz_zero,n,1)).^2));

end