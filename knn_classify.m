clc;
clear ;
close all;
warning off all;

load WeatherForecasting.mat  % fea group
[filename, path]=uigetfile('*.jpg*');
c=[path filename];
im=imread(c);

face=imresize(im,[50 50]);
imshow(face)
pause(.3)
figure
face = rgb2gray(face);

imshow(face)
pause(0.01)
[test_feat] = hog_feature_vector(face); % hog_feature_vector fuction returns features of the given image

c=knnclassify(test_feat,fea,group); % this function calculate the distance between the test festures and trained features and returns a class label

if c==1
    msgbox('Cloudy Season ')
end

if c==2
    msgbox ('Rainy_Season')
end

if c==3
    msgbox('Sunshine')
end


