clc, close all, clear all





rgb1 = imread('E:\�������\��ҵ����\code\numbers\9.bmp');

[m,n]=size(rgb1);
for x=1:m
    for y=1:n
        if rgb1(x,y)==1
            rgb1(x,y)=0;
        else
            rgb1(x,y)=1;
        end
    end
end
imwrite(rgb1,'E:\�������\��ҵ����\code\numbers\9.bmp');
