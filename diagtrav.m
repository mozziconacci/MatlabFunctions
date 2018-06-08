function [b,c] = diagtrav(A)

%% Traverse a square matrix in anti-diagonal order.
%  Author: Loc Canonne-Velasquez   loic.cv@gmail.com
%The first output is a vector with the elements of A read out in 
%anti-diagonal order. The second output is the sum of the elements along 
%each anti-diagonal.
%Example:   A = [1 2 3; 4 5 6; 7 8 9]
%           [b,c] = diagtrav(A);
%           b = [1 2 4 3 5 7 6 8 9]
%           c = [1 6 15 14 9]

temp1 = size(A);
if (numel(temp1) > 2)
    error('Input is not a matrix');
elseif (temp1(1) ~= temp1(2))
    error('Input is not a square matrix');
else
    L = temp1(1);   %determine size of input matrix
    
    b = zeros(numel(A),1);
    c = zeros(2*L-1,1);
    ii = 1;
    jj = 1;
    for i = 1:L
        c(jj) = 0;
        for j = 1:i
            b(ii) = A(j,i);
            c(jj) = c(jj) + b(ii);
            i = i-1;
            ii = ii+1;
        end
        jj = jj+1;
    end
    
    for j = 2:L
        c(jj) = 0;
        for i = L:-1:j
            b(ii) = A(j,i);
            c(jj) = c(jj) + b(ii);
            ii = ii+1;
            j = j+1;
        end
        jj = jj+1;
    end
end
