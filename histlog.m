function [] = histlog(A, bin)


figure, loglog(min(A):(max(A)-min(A))/bin:max(A),hist(A,bin+1));

end
