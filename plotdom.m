function plotdom(cdata1)
%CREATEFIGURE1(CDATA1)
%  CDATA1:  image cdata

%  Auto-generated by MATLAB on 22-May-2014 16:53:56

% Create figure
figure1 = figure('Colormap',...
    [1 1 1;1 1 0.993808031082153;1 1 0.987616121768951;1 1 0.981424152851105;1 1 0.975232183933258;1 1 0.969040274620056;1 1 0.962848305702209;1 1 0.956656336784363;1 1 0.950464427471161;1 1 0.944272458553314;1 1 0.938080489635468;1 1 0.931888580322266;1 1 0.925696611404419;1 1 0.924767792224884;1 1 0.923839032649994;1 1 0.922910213470459;1 1 0.921981453895569;1 1 0.921052634716034;1 1 0.877192974090576;1 1 0.833333313465118;1 1 0.789473712444305;1 1 0.745614051818848;1 1 0.70175439119339;1 1 0.657894730567932;1 1 0.614035069942474;1 1 0.570175468921661;1 1 0.526315808296204;1 1 0.482456147670746;1 1 0.438596487045288;1 1 0.394736856222153;1 1 0.350877195596695;1 1 0.307017534971237;1 1 0.263157904148102;1 1 0.219298243522644;1 1 0.175438597798347;1 1 0.131578952074051;1 1 0.0877192988991737;1 1 0.0438596494495869;1 1 0;1 0.941176474094391 0;1 0.882352948188782 0;1 0.823529422283173 0;1 0.764705896377563 0;1 0.705882370471954 0;1 0.647058844566345 0;1 0.588235318660736 0;1 0.529411792755127 0;1 0.470588237047195 0;1 0.411764711141586 0;1 0.352941185235977 0;1 0.294117659330368 0;1 0.235294118523598 0;1 0.176470592617989 0;1 0.117647059261799 0;1 0.0588235296308994 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0;0.5 0 0]);

% Create axes
axes1 = axes('Parent',figure1,'YDir','reverse','Layer','top');
% Uncomment the following line to preserve the X-limits of the axes
[y,x]=size(cdata1);
xlim(axes1,[1 x]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes1,[1 y]);
box(axes1,'on');
hold(axes1,'all');

% Create image
image(cdata1,'Parent',axes1,'CDataMapping','scaled');
axis image
% Create colorbar
colorbar('peer',axes1);
