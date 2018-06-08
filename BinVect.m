function CBin = BinVect(CB,V)

[i,j,d] = find(CB);
list = [i,j,d];
ml = length(list);

mv = length(V);
mb = length(CB);
numj = zeros(mb,1);

val0=1;
val1=V(1,1);

for i=1:(mv+1)
   
    for j=val0:val1
        
        numj(j,1)=i;
        
    end
    
    if i<mv
        val0=V(i,1);
        val1=V(i+1,1);
    end
    
    if i==mv
        val0=V(i,1);
        val1=mb;
    end
    
end

% CBin_regular=zeros(mv+1);
% CBin_regular_count=zeros(mv+1);

CBin_regular=sparse(mv+1,mv+1);
CBin_regular_count=sparse(mv+1,mv+1);

for k=1:ml

    CBin_regular(numj(list(k,1)),numj(list(k,2))) = CBin_regular(numj(list(k,1)),numj(list(k,2))) + list(k,3);
    CBin_regular_count(numj(list(k,1)),numj(list(k,2))) = CBin_regular_count(numj(list(k,1)),numj(list(k,2))) + 1;
end

CBin_regular = CBin_regular./CBin_regular_count;    

CBin = CBin_regular;

% [ib,jb,db] = find(CBin_regular);
% db(isnan(db))=0;
% CBin = sparse(ib,jb,db);



% CBin=zeros(mb,mb);

% vali0=1;
% vali1=V(1,1);
% 
% for i=1:(mv+1)
%     
%     valj0=1;
%     valj1=V(1,1);
%     
%     for j=1:(mv+1)
%         
%         CBin(vali0:vali1,valj0:valj1) = CBin_regular(i,j);
%         
%         if j<mv
%             valj0=V(j,1);
%             valj1=V(j+1,1);
%         end
%         if j==mv
%         valj0=V(j,1);
%         valj1=mb;
%         end
%         
%     end
%     
%     if i<mv
%         vali0=V(i,1);
%         vali1=V(i+1,1);
%     end
%     if i==mv
%         vali0=V(i,1);
%         vali1=mb;
%     end
% end


end

