function [ header, data ] = fromupdiag( filename )
%FROMUPDIAG This function load an upper diagonal matrix from file
%   Just pass the filename

    fid = fopen(filename);
    headline = fgets(fid);
    fclose(fid);
    header = strsplit(strtrim(headline), '\t');
    header(1) = [];
    
    data = dlmread(filename, '\t', 1, 1);
    dsize = size(data);
    dsize(1) = [];
    for n = 1:dsize
        data(n, n:dsize) = data(n, 1:dsize-n+1);
        data(n, 1:n-1) = zeros(1, n-1);
    end
end

