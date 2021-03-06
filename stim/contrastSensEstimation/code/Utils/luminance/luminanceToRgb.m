function [linInput] = luminanceToRgb(lumRequired, bitsRes, pathToGreyData)

if nargin<3  
    pathToGreyData=fullfile(pwd,'Utils','luminance','NecsusNolightGray-rgblum11-Dec-2018.mat');
    %'Common\LCD_linear_Acromatic_grey_data.mat';
    
    disp('[Warning] default: lcd monitor lab95.')
end

if nargin<2
    bitsRes=8;
end

if nargin<1
    lumRequired=20;
end

% --- load data ---
% LCD monitor RGB matrix on input
% returns RGB_lum (true output), FitParamters (gamma, offset)
load(pathToGreyData);

maxLum=max(RGB_lum(:,2));

% Assuming linear CLUT.
linInput=lumRequired/maxLum;

end