function [C] = smooth2bis(X, dimmode)

s = [0.1 0.1 0.1; 0.1 0.2 0.1; 0.1 0.1 0.1];
C = conv2(s,X);
for i = 1:1:dimmode-1
C = conv2(s,C);
end
C=C(dimmode+1:end-dimmode,dimmode+1:end-dimmode);
end
