clc, close all, clear all

img0 = imread('E:\论文相关\毕业论文\code\numbers\0.bmp');
img1 = imread('E:\论文相关\毕业论文\code\numbers\1.bmp');
img2 = imread('E:\论文相关\毕业论文\code\numbers\2.bmp');
img3 = imread('E:\论文相关\毕业论文\code\numbers\3.bmp');
img4 = imread('E:\论文相关\毕业论文\code\numbers\4.bmp');
img5 = imread('E:\论文相关\毕业论文\code\numbers\5.bmp');
img6 = imread('E:\论文相关\毕业论文\code\numbers\6.bmp');
img7 = imread('E:\论文相关\毕业论文\code\numbers\7.bmp');
img8 = imread('E:\论文相关\毕业论文\code\numbers\8.bmp');
img9 = imread('E:\论文相关\毕业论文\code\numbers\9.bmp');
img10 = imread('E:\论文相关\毕业论文\code\numbers\10.bmp');
img11 = imread('E:\论文相关\毕业论文\code\numbers\11.bmp');
img12 = imread('E:\论文相关\毕业论文\code\numbers\12.bmp');

r0=charFeature(img0);
r1=charFeature(img1);
r2=charFeature(img2);
r3=charFeature(img3);
r4=charFeature(img12);
r5=charFeature(img5);
r6=charFeature(img6);
r7=charFeature(img7);
r8=charFeature(img8);
r9=charFeature(img9);
r10=charFeature(img10);
r11=charFeature(img11);
c0=r0.feature;
c1=r1.feature;
c2=r2.feature;
c3=r3.feature;
c4=r4.feature;
c5=r5.feature;
c6=r6.feature;
c7=r7.feature;
c8=r8.feature;
c9=r9.feature;
c10=r10.feature;
c11=r11.feature;

save 'chars.txt' c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 -ascii -double


%{
info=regionprops(img,'BoundingBox');
[m,n]=size(img);
figure;imshow(img);
num=0;

for i=1:length(info)
    rect=info(i).BoundingBox;
   % if img(floor(rect(1)+rect(3)/2),floor(rect(2)+rect(4)/2))==1
        disp(rect)
        if floor(rect(1))==0 || floor(rect(1)+rect(3))>n-2 || floor(rect(2))==0 || floor(rect(2)+rect(4))>m-2
            disp(rect(2)+rect(4))
            disp(n-2)
        else
            
            rectangle('Position',rect,'LineWidth',3,'EdgeColor','r');
            num=num+1;
        end
   % end
end

disp(num);
%}

