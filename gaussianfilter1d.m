function yfilt = gaussianfilter1d(y,sigma,s)

% std % sigma = 5;
%size % s = 30;
x = linspace(-s / 2, s / 2, s);
gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2));
gaussFilter = gaussFilter ./ sum (gaussFilter); % normalize

yfilt = filter (gaussFilter,1, y);

end
