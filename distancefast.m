function dist = distancefast(X,Y)

  dist = bsxfun(@plus,dot(X,X,1)',dot(Y,Y,1))-2*(X'*Y);
	%dist=sqrt(dist);
end

