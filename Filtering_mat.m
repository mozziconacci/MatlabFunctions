function CBF = Filtering_mat(CB_f,CB,mini,maxi)

disp('Filtering min/max')
CBF=CB(sum(CB_f)<maxi & sum(CB_f)>mini, sum(CB_f)<maxi & sum(CB_f)>mini);

end