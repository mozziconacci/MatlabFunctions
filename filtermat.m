function [Data] = filtermat(Data)
mini= mean(sum(Data))-1.5*std(sum(Data));
maxi= mean(sum(Data))+1.5*std(sum(Data));
trash=find(sum(Data)<mini | sum(Data)>maxi);
Data(trash,:)=0;
Data(:,trash)=0;

end
