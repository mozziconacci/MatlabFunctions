function [Cn] = im_scale(C)

Cn=69*(C-min(min(C)))/(max(max(C))-min(min(C)));

end