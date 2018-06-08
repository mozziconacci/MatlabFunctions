function varargout=hist2(X,u,v)
% HIST2 2D histogram.
%
%   hist2(X)
%   hist2(X,num)
%   hist2(X,u,v)
%   N=hist2(...)
%   [N,u,v]=hist2(...)
%
%   X: n-by-2-matrix
%
%   Example:
%     hist2(X,100) % Plots a histogram image with 100
%                  % bins in each direction.
%
%     % Often nicer:
%     [N,u,v]=hist2(X,100);
%     surf(u,v,log(1+N)),shading interp,view(0,90),axis tight

% $Revision: 2952 $  $Date: 2006-09-22 18:45:42 +0200 (Fri, 22 Sep 2006) $

if nargin<3
  if nargin<2
    num=10;
  else
    num=u;
  end
  if length(num)<2
    num=[num num];
  end
  mini=min(X);
  maxi=max(X);
  u=linspace(mini(1),maxi(1),num(1)+1);
  v=linspace(mini(2),maxi(2),num(2)+1);
else
  num=[length(u),length(v)];
end
n=size(X,1);

idx = (X-ones(n,1)*[u(1),v(1)])./...
      (ones(n,1)*([u(end),v(end)]-[u(1),v(1)])).*...
      (ones(n,1)*num);
idx(idx(:,1)<0,:)=[];
idx(idx(:,2)<0,:)=[];
idx(idx(:,1)>num(1),:)=[];
idx(idx(:,2)>num(2),:)=[];
idx = ceil(idx);
idx(idx==0)=1;

N = full(sparse(idx(:,2),idx(:,1),ones(size(idx,1),1),num(2),num(1)));

if nargout==0
  h=image(u,v,N/max(N(:)));
  set(h,'CDataMapping','scaled')
  axis xy
end
if nargout>=1
  varargout{1}=N;
end
if nargout>=2
  varargout{2}=conv2(u,[0.5,0.5],'valid');
end
if nargout>=3
  varargout{3}=conv2(v,[0.5,0.5],'valid');
end