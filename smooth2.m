function [C] = smooth(X, dimmode)

s = [0.05 0.05 0.05; 0.05 0.55 0.05; 0.05 0.05 0.05];
C = conv2(s,X);
for i = 1:1:dimmode-1
C = conv2(s,C);
end
C=C(dimmode+1:end-dimmode,dimmode+1:end-dimmode);
end
