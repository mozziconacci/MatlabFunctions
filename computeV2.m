function V2 = computeV2(CB,diago)

%rm diag
CB=rm_diag(CB,diago);

%filter
sCB = sum(CB);
sCB = sCB(sCB>1);

figure, hist(sCB,100000)
mini = input('Enter mini ');
maxi = input('Enter maxi ');

test_f=Filtering_mat(CB,CB,mini,maxi);

%rm diag
test_rd_f=rm_diag(test_f,diago);

%SCN
test_rd_f_n=SCN_sumV2(test_rd_f);

%OE
[test_rd_f_n_oe,exp]=observed_expected(test_rd_f_n,length(test_rd_f_n));

%V2
[V,D]=eigs(test_rd_f_n_oe,3);

%Kalman filter
V2=Kalman1D(V(:,2),(max(V(:,2))-min(V(:,2))/10));

end