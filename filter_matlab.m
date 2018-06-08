function filter_matlab(CB,CB_f,data_name,scale_max)

disp('Importing Data')
[m,n] = size(CB);

%Removing Small Diagonal
% [CB,CB_f] = rm_small_diag(CB,CB_f);
CB = rm_diag(CB,2);
CB_f = rm_diag(CB_f,2);

disp('Computing mini,maxi...')
sCB = sum(CB);
sCB = sCB(sCB>1);
mini = mean(sCB)-std(sCB);
maxi = mean(sCB)+std(sCB);
if mini<2
    mini=2;
end
[mini,maxi]
figure, hist(sCB,m/10);

%Filtering
CBF = Filtering_mat(CB_f,CB,mini,maxi);
CBF = rm_diag(CBF,2);
[mf,nf] = size(CBF);
figure, hist(sum(CBF),mf/10);
%Assembling matrices
% CBF = repmat(CBF,2);
% figure,imagesc(CBF)
CBW=CBF;

disp('--------------Wavelet Filtering----------')

%Slicing the matrix
% p=1;
% q=100000;
% [m,n] = size(CBW);

% CBW=CBW(p:q,p:q);

%Set one to contact
% CBW = set_one(CBW);

%SCN
disp('SCN')
CBW = SCN_sumV2(CBW);   

% Observed/expected
CBW = observed_expected(CBW,scale_max);

%Wavelet normalization
% CBWN = wavelet_norm(CBW,scale_max);

%Removing inf
% disp('Removing inf')
% CBO(isinf(log10(CBO)))=1;

f_data_tab = set_normalisation(CBW,scale_max);



disp('saving')
f_data = CBW;
% save(strcat('f_',data_name,'.mat'),'f_data');
f_data_bin = CBW;
save(strcat('f_',data_name,'.mat'),'f_data','f_data_bin','f_data_tab','-v7.3') ;


disp('--------------Compartiment Filtering----------')

%Remove Big Diagonal
CB5 = rm_diag(CBF,500);

% disp('Enrich1')
% CB5=enrich1(CB5);
% CB5=enrich1(CB5);
% CB5=enrich1(CB5);

%Set one to contact
% CB5 = set_one(CB5);


disp('Diagonalisation')
[V,D]=eigs(CB5,2);

disp('Filtering min/max of gene coord file')
%filtering
[m,n]=size(CB);
% G=load('G_hesc.txt');
% GC=G(1:m);
GC = 1:m;
GF=GC(sum(CB_f)<maxi & sum(CB_f)>mini);

disp('saving vp')
f_data_vp = V(:,2);
f_data_vp_position = GF;
% figure, plot(f_data_vp)
save(strcat('f_', data_name,'_vp.mat'),'f_data_vp_position','f_data_vp','-v7.3');

end