function [c] = correlation(V1,V2);

c=sum((V1-mean(V1)).*(V2-mean(V2))/(std(V1)*std(V2)))/length(V1);

end
