
function [c] = graphtodist(a)

 n = size(a,1);
 c = repmat(inf,n,n);
 for k = 1:n
   f = k;
   s = 0;
   while ~isempty(f)
     c(k,f) = s;
     s = s+1;
     f = find(any(a(f,:),1)&c(k,:)==inf);
   end
 end
