% smoothsig

function [A] = smoothsig(donnees,num);

windowSize = num;
B=filter(ones(1,windowSize)/windowSize,1,donnees);
A=cat(2,B(num)*ones(1,round(num/2)-1),B(num:end), B(end)*ones(1,round(num/2)));

end
