function [zmat,zmatF,zmatFB] = zscore(matrix,res,threshold)

[M,N] = size(matrix);
zmat = zeros(M,length(matrix));

for i=[1:M]
    
matrixi = matrix(i,:);

for k=1:N
if k==res+1
sumi = sum(matrixi(k-res:k+res));
sumi2 = sum(matrixi(k-res:k+res).^2);
norm = length(find(matrixi(k-res:k+res))~=0);
if norm == 0
normnz=1;
else
normnz = norm;
end
meanmat = sumi/normnz;
varmat = sumi2/normnz - (sumi/normnz)^2;
if varmat <= 0
stdmatnz=1;
else
stdmatnz = sqrt(varmat);
end
zmat(i,k) = (matrix(i,k)-meanmat)/stdmatnz;
end
if k>res+1 && k<=N-res
sumi = sumi + matrixi(k+res)-matrixi(k-1-res);
sumi2 = sumi2 + matrixi(k+res)^2-matrixi(k-1-res)^2;
norm = norm + (matrixi(k+res)>0) - (matrixi(k-1-res)>0);
if norm == 0
normnz=1;
else
normnz = norm;
end
meanmat = sumi/normnz;
varmat = sumi2/normnz - (sumi/normnz)^2;
if varmat <= 0
stdmatnz=1;
else
stdmatnz = sqrt(varmat);
end

zmat(i,k) = (matrix(i,k)-meanmat)/stdmatnz;
end
if k<=res || k > N-res
start = k-res;
stop = k+res;
if start<1
start = 1;
end
if stop > N
stop=N;
end
sumi = sum(matrixi(start:stop));
sumi2 = sum(matrixi(start:stop).^2);
norm = length(find(matrixi(start:stop))~=0);
if norm==0
normnz=1;
else
normnz=norm;
end
meanmat = sumi/normnz;
varmat = sumi2/normnz - (sumi/normnz)^2;
if varmat <= 0
stdmatnz=1;
else
stdmatnz = sqrt(varmat);
end
zmat(i,k) = (matrix(i,k)-meanmat)/stdmatnz;
end
end
i,
end

thresholdmatcut =ones(size(zmat))*threshold;
Mask = bsxfun(@ge, zmat, thresholdmatcut);
zmatF = zeros(size(zmat));
zmatF(Mask) = zmat(Mask) ;
zmatFB = zmatF;
zmatFB(zmatF>0)=1;
end