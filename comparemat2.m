function[spear,disterr,matdisterr]=comparemat2(dtot,dsecond)

s=size(dsecond);
n=s(2);
nn=n*n;

dreshape=reshape(dtot,1,nn);
dsecondreshape=reshape(dsecond,1,nn);
[ds,di]=sort(dreshape);
cont=[1:nn];
dsecondr=dsecondreshape(di);
[dss,dsi]=sort(dsecondr);
[dcs,dci]=sort(dsi);
ddv=cont-dci;
ddv=ddv.*ddv;
sommedcarre=sum(ddv);
spear=1-(6*sommedcarre)/(nn*(nn*nn-1));

% [polyg,struct]=polyfit(dreshape,dsecondreshape,1);
% [dsecrecalc,delta]=polyval(polyg,dreshape,struct);

polyg2=mean(dsecondreshape)/mean(dreshape);
polyg2
%dreshape=dreshape*polyg(1); VARIANT

dreshape=dreshape*polyg2;

% bornmin1=min(dreshape);
% bornmax1=max(dreshape);
% bornmin2=min(dsecondreshape);
% bornmax2=max(dsecondreshape);
% ecart1=(bornmax1-bornmin1)/50;
% ecart2=(bornmax2-bornmin2)/50;
% [mat,vectorx,vectory]=hist2d(dreshape,dsecondreshape,[bornmin1,bornmax1],ecart1,[bornmin2,bornmax2],ecart2);
% 
% figure, imagesc(vectorx,vectory,mat);
% title('histograme des distances (x) et distances reconsrtuites (y)')

%dreshape=dreshape*polyg(1);

disterr=0;
compteur=0;
    
    for k=1:nn
        if(dreshape(k)~=0)
            if(dsecondreshape(k)~=0)
                disterr=disterr+abs(dreshape(k)-dsecondreshape(k))./(dreshape(k)+dsecondreshape(k));
                compteur=compteur+1;
            end
        end
    end 
     
    vecteurdist=abs(dreshape-dsecondreshape);
    vectmoydist=(dreshape+dsecondreshape);
%   vectmoydist=(dreshape);
    vectdisterror=(vecteurdist)./(vectmoydist);
    matdisterr=reshape(vectdisterror,n,n);
    
    
        
    
disterr=disterr/compteur;
disterr=1-disterr;

disp(['erreur relative sur les distances ='])
disterr

disp(['correlation de spearman ='])
spear


% save('correspearman.txt','-ascii','correspearman');
% save('delta.txt','-ascii','delta');

end
