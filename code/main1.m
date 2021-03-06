% Clear all
clc, close all, clear all
% Read image
%src=imread('E:\projects\南瑞互感器相关项目\项目——互感器外观智能识别\可用图像\ming.jpg');
src=imread('minggray.jpg');

imshow(src);title('INPUT IMAGE WITH NOISE')

%{
% Convert to gray scale
if size(src,3)==3 %RGB image
    gray=rgb2gray(src);
    figure(1)
    %imwrite(gray, 'gray.jpg');
    imshow(gray);
end

[m,n]=size(gray);
for  x=1:m
    for y=1:n
        if gray(x,y)>210
            gray(x,y)=180;
        end
        
        if x<60&&y<200
                if gray(x,y)<160 
                gray(x,y)=gray(x,y)-40;
                end
        else
            if x>=60&&y<120
                if gray(x,y)< 160
            gray(x,y)=gray(x,y)-40;
                end
            
            else
                if gray(x,y)< 60
                gray(x,y)=gray(x,y)-20;
                end
            end
        end
            
    end
end
figure(2)
    imwrite(gray, 'minggray.jpg');
    imshow(gray);
%}
% Convert to BW
threshold = graythresh(src);
binary = ~im2bw(src,0.52);
imwrite(binary, 'mingbinary.jpg');
figure(3),imshow(binary);
