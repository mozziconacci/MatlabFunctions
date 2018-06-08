
function [distmat] = Aihara(data)

n=length(data);
if 10000<n
    'array too large for Aihara'
 return
end

cmat=corrcoef(data);
dismat=ones(n)-cmat;
distmat(data==0)

end


        
