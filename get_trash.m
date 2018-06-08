function [trash] = get_trash(matrix1)

%filter
summat=sum(matrix1);
meansum=mean(summat);
stdsum=std(summat);

if (meansum < 1.5*stdsum)
    disp('filtering problem');
    meansum=2*stdsum;
end

trash=(summat > meansum+1.5*stdsum | meansum-1.5*stdsum>summat);

end
