function CBin = BinVect_unzip(CB,V)

mb = length(CB);
mv = length(V);

CBin=zeros(mb,mb);

vali0=1;
vali1=V(1,1);

for i=1:(mv+1)
    
    valj0=1;
    valj1=V(1,1);
    
    for j=1:(mv+1)
        
        CBin(vali0:vali1,valj0:valj1) = CB(i,j);
        
        if j<mv
            valj0=V(j,1);
            valj1=V(j+1,1);
        end
        if j==mv
        valj0=V(j,1);
        valj1=mb;
        end
        
    end
    
    if i<mv
        vali0=V(i,1);
        vali1=V(i+1,1);
    end
    if i==mv
        vali0=V(i,1);
        vali1=mb;
    end
end

end