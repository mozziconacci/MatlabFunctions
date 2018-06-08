function [Data,v] = pdbfromraw(Data,x,y)

% %On enlève la bin la plus forte %
% x=x(sum(Data)~=max(sum(Data)));
% Data=Data(sum(Data)~=max(sum(Data)),sum(Data)~=max(sum(Data)));
% % On enlève la bin la plus forte %
% x=x(sum(Data)~=max(sum(Data)));
% Data=Data(sum(Data)~=max(sum(Data)),sum(Data)~=max(sum(Data)));

mini= mean(sum(Data))-2*std(sum(Data));
maxi= mean(sum(Data))+2*std(sum(Data));
garde=find(sum(Data)>max(mini,0) & sum(Data)<maxi);
Data=Data(garde,garde);
x=x(garde);

%Despeckele
seuil=0.5;
Data=despeckele(Data,seuil);

%On enlève la diago
Data=Data-diag(diag(Data));

%SCN
Data=SCN_sumV2(Data);

%%% Remove 1148 for SynXII_ChrIII_rDNA_18 ONLY !!%%%%
% Data=Data([1:1147,1149:end],[1:1147,1149:end]);
% x= x([1:1147,1149:end]);
%%% Remove 1148 for SynXII_ChrIII_rDNA_17 ONLY !!%%%%
% Data=Data([1:1142,1144:end],[1:1142,1144:end]);
% x= x([1:1142,1144:end]);
%%% Remove 36 and 103 for Cramble Zoom ONLY !!%%%%
% Data=Data([1:35,37:end],[1:35,37:end]);
% x= x([1:35,37:end]);
% Data=Data([1:101,103:end],[1:101,103:end]);
% x= x([1:101,103:end]);

figure, imagesc(-log10(Data));
caxis([0.5,4]);
colorbar
axis equal
axis tight
colormap(hot)

v=x;


% Color chromosomes with length
colarm=zeros(length(Data),1);
for i=1:length(Data)
   colarm(i)= sum(x==x(i));
end


temp=FastFloyd(1./Data);     
temp=temp-diag(diag(temp));
XYZ_rep=mdscale(temp,3,'criterion','strain');
[pts, V]= convhulln(XYZ_rep);
scale=100/V^(1/3);
XYZ_rep=XYZ_rep*scale;

data.X = XYZ_rep(:,1);
data.Y = XYZ_rep(:,2);
data.Z = XYZ_rep(:,3);
data.resNum=x;
data.occupancy=colarm/max(colarm);
data.outfile = y;
data.atomName = cell(1,length(XYZ_rep));
data.atomName(1:end) = {'OW'};
mat2pdb(data)



end
