function [ zmat ] = zmat( A )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

meanmat=mean(A);
stdmat=std(A);
stdmat(stdmat==0)=1;
zmat=(A-sqrt(meanmat'*meanmat))./sqrt(stdmat'*stdmat);

end

