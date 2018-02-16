clc;close all;clear;
warning off all;
load WeatherForecasting.mat % fea group-
class = zeros(3,numel(group));      % create 3x69 matrix

for i =1:numel(unique(group))
    class(i,:) = group == i;        % create a logical matrix corresponding to each group
end


[a, b]= uigetfile('*.*');
filename = [b,a];
im=imread(filename);
% imshow(im);
imshow(im)
figure
face = rgb2gray(im);

imshow(face)
pause(0.01)
%

imshow(im)
face=imresize(im,[50 50]);
[test_sample] = hog_feature_vector(face);




class_t = class';

x = fea';
t = class_t';
% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 90/100;
net.divideParam.valRatio = 5/100;
net.divideParam.testRatio = 5/100;

% Train the Network
[net,tr] = train(net,x,t);   % x is your input and t is your group (BInary form)

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
% view(net)


% test the sample
test_n = net(test_sample');
c = vec2ind(test_n)


if c==1
    msgbox('Cloudy Season ')
end

if c==2
    msgbox ('Rainy_Season')
end

if c==3
    msgbox('Sunshine')
end


% Plots
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, ploterrhist(e)
figure, plotconfusion(t,y)
figure, plotroc(t,y)

