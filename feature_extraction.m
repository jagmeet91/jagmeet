clc;  clear ; close all;
warning off all;
fea=[];
group=[];

folder=dir('E:\project\WeatherForecasting\project\database');    %database directory
count=0;



for mn=3:length(folder)
    count=count+1;
    address=strcat('E:\project\WeatherForecasting\project\database\',folder(mn).name);  %concatenate with class lable names i.e subdirectories
    folder(mn).name
    files=dir(address);
    num=numel(files);
    count
    for i=3:num
        str=strcat('E:\project\WeatherForecasting\project\database\',folder(mn).name,'\',files(i).name);
        
        files(i).name
        
        im=imread(str);
        
            face=imresize(im,[50 50]);
            imshow(face)
            pause(.3)
            figure
            face = rgb2gray(face);    %conversion rbg image to grey scale
            
            imshow(face)
            pause(0.01)
             
            
            [feature] = hog_feature_vector(face);% hog_feature_vector fuction returns features of the given image

            fea=[fea;feature];
            group=[group, count];
         
    end
end
save WeatherForecasting fea group 