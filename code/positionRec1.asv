clc, close all, clear all

src=imread('E:\论文相关\毕业论文\img\zhengmian3.jpg');
%src=imread('E:\论文相关\毕业论文\img\daotest1.jpg');
%src=imread('E:\论文相关\毕业论文\img\voidtest.jpg');
%src=imread('E:\论文相关\毕业论文\img\fanxiang4.jpg');
%src = imread('E:\论文相关\毕业论文\img\void1.jpg');
void = imread('E:\论文相关\毕业论文\img\void1.jpg');
set(0,'defaultFigurePosition',[100,100,1000,500]);
set(0,'defaultFigureColor',[1,1,1]);

%subplot(2,1,1);imshow(src);title('原图像');
%subplot(2,1,2);imshow(void);title('空背景');
%chafen = imsubtract(src, void);
figure;

%ee=imadjust(src,[0.7 0.7 0.1;1 1 0.3],[0.6 0.6 0.8;0.8 0.8 1],[]);
ee=imadjust(src,[0.3 0.7],[0 1],[]);
%dd=histeq(src,16);
%figure; imshow(ee);

subplot(2,2,1);imshow(ee);title('原图像');
[m_ok,n_ok,g_ok]=size(ee);
hu_ok = imcrop(ee,[40,100,n_ok-80,m_ok-200]);
subplot(2,2,2);imshow(hu_ok);title('互感器');
[m_ok,n_ok,g_ok]=size(hu_ok);
bluePixel = 0;
for x=1:m_ok-1
    for y=1:n_ok-1
        if hu_ok(x,y,3)>(hu_ok(x,y,2)-2)&& hu_ok(x,y,3)>(hu_ok(x,y,1)-2)
            bluePixel=bluePixel+1;
        end
    end
end
disp(bluePixel/m_ok/n_ok);
hu_status=0; %0无，1正常，2颠倒，3倾斜
if bluePixel>m_ok*n_ok*0.9
    hu_status=0;
    disp('没有互感器');
else if bluePixel>m_ok*n_ok*0.2
        hu_status=1;
        disp('互感器有可能倾倒');
    else
        hu_status=2;
        disp('互感器正常或颠倒');
    end
end


gray_ok=rgb2gray(hu_ok);
subplot(2,2,3);imshow(gray_ok);title('灰度图像');
threshold_ok = graythresh(gray_ok);
binary_ok = ~im2bw(gray_ok,threshold_ok);
subplot(2,2,4);imshow(binary_ok);title('二值图像');

[B,L] = bwboundaries(binary_ok, 'noholes');
STATS = regionprops(L, 'all'); 
% Square = 3 = (1 + 2) = (X=Y + Extent = 1)
% Rectangular = 2 = (0 + 2) = (only Extent = 1)
% Circle = 1 = (1 + 0) = (X=Y , Extent < 1)
% UNKNOWN = 0

figure,
imshow(binary_ok),
title('Results');
hold on
for i = 1 : length(STATS)
  W(i) = uint8(abs(STATS(i).BoundingBox(3)-STATS(i).BoundingBox(4)) < 0.1);
  W(i) = W(i) + 2 * uint8((STATS(i).Extent - 1) == 0 );
  centroid = STATS(i).Centroid;
  switch W(i)
      case 1
          plot(centroid(1),centroid(2),'wO');
      case 2
          plot(centroid(1),centroid(2),'wX');
      case 3
          plot(centroid(1),centroid(2),'wS');
  end
end
return

