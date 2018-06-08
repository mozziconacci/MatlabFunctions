function C = FindTADborderByWavelet(hic,h)

    if mod(h,2)==1
       disp('Please enter a EVEN wavelet size') 
       return
    end

    %Wavelet matrix
    W = zeros(h,h);
    for i = 1:h
        for j=1:h
            if (i>0 && j>0) || (i<0 && j<0)
                W(i,j) = 1;
            end

            if ( i>0 && j<0) || (i<0 && j>0)
                W(i,j) = -1;
            end
        end
    end

    W = reshape(W,h*h,1)/h^2;

    %Navigation on HiC Map
    h2 = h/2;
    C = zeros(length(hic),1);
    for k=h2:length(hic)-h2
        C(k) = reshape(hic(k-h2+1:k+h2,k-h2+1:k+h2),1,h*h)*W;
    end
    
end