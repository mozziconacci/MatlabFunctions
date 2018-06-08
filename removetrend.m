function [B ] = removetrend( A )
% Remove trend of V1
windowSize = ceil(length(A)/10);

b = (1/windowSize)*ones(1,windowSize);
a = 1;



B = filter(b,a,A);

figure,
plot(A)
hold on
plot(B)
legend('Input Data','Filtered Data')
end

