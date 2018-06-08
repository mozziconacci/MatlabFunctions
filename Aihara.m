
function [distmat] = Aihara(data)

n=length(data);
if 10000<n
    print('array too large for Aihara')
 return
end

cmat=corrcoef(data);
distmat=ones(n)-cmat;
distmat=1./distmat;
distmat(data==0)=0;


end


        
