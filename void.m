clc, close all, clear all
rgb1 = imread('E:\论文相关\毕业论文\code\hu_zhengmian.jpg');
[m1,n1,g2]=size(rgb1);
hsi1=rgb2hsi(rgb1);
h1=hsi1(:, :, 1);
subplot(2,2,2);hist(h1)
xlabel('（b）互感器正常时图像的色调直方图');

rgb2 = imread('E:\论文相关\毕业论文\code\hu_void.jpg');
[m2,n2,g2]=size(rgb1);
hsi2=rgb2hsi(rgb2);
h2=hsi2(:, :, 1);
subplot(2,2,1);hist(h2)
xlabel('（a）无互感器时图像的色调直方图');


rgb3 = imread('E:\论文相关\毕业论文\code\hu_dao.jpg');
[m3,n3,g3]=size(rgb3);
hsi3=rgb2hsi(rgb3);
h3=hsi3(:, :, 1);
subplot(2,2,4);hist(h3)
xlabel('（d）互感器倾倒时图像的色调直方图');

rgb4 = imread('E:\论文相关\毕业论文\code\hu_fanxiang.jpg');
[m4,n4,g2]=size(rgb4);
hsi4=rgb2hsi(rgb4);
h4=hsi4(:, :, 1);
subplot(2,2,3);hist(h4)
xlabel('（c）互感器颠倒时图像的色调直方图');


figure;
subplot(2,2,2);imshow(rgb1)
xlabel('（b）互感器正常时的图像');
subplot(2,2,1);imshow(rgb2)
xlabel('（a）无互感器时的图像');
subplot(2,2,4);imshow(rgb3)
xlabel('（d）互感器倾倒时的图像');
subplot(2,2,3);imshow(rgb4)
xlabel('（c）互感器颠倒时的图像');


src1 = imread('E:\论文相关\毕业论文\img\zhengmian3.jpg');
bg1 = imcrop(src1,[5,5,4,4]);
%箱子的色度
bg_hsi1=rgb2hsi(bg1);
bg_h1=bg_hsi1(:,:,1);
avg_h1=sum(bg_h1(:))/25;
low_h1=avg_h1-0.2;
hight_h1=avg_h1+0.2;

src2 = imread('E:\论文相关\毕业论文\img\void1.jpg');
bg2 = imcrop(src2,[5,5,4,4]);
%箱子的色度
bg_hsi2=rgb2hsi(bg2);
bg_h2=bg_hsi2(:,:,1);
avg_h2=sum(bg_h2(:))/25;
low_h2=avg_h2-0.2;
hight_h2=avg_h2+0.2;

src3 = imread('E:\论文相关\毕业论文\img\dao2.jpg');
bg3 = imcrop(src3,[5,5,4,4]);
%箱子的色度
bg_hsi3=rgb2hsi(bg3);
bg_h3=bg_hsi3(:,:,1);
avg_h3=sum(bg_h3(:))/25;
low_h3=avg_h3-0.2;
hight_h3=avg_h3+0.2;

src4 = imread('E:\论文相关\毕业论文\img\fanxiang4.jpg');
bg4 = imcrop(src4,[5,5,4,4]);
%箱子的色度
bg_hsi4=rgb2hsi(bg4);
bg_h4=bg_hsi4(:,:,1);
avg_h4=sum(bg_h4(:))/25;
low_h4=avg_h4-0.1;
hight_h4=avg_h4+0.1;


l1=find(h1>-1);
l2=find(h2>-1);
l3=find(h3>-1);
l4=find(h4>-1);
A1=find(h1>low_h1 & h1<hight_h1);
a1=length(A1)/length(l1);
A2=find(h2>low_h2 & h2<hight_h2);
a2=length(A2)/length(l2);
A3=find(h3>low_h3 & h3<hight_h3);
a3=length(A3)/length(l3);
A4=find(h4>low_h4 & h4<hight_h4);
a4=length(A4)/length(l4);
disp(a1)
disp(a2)
disp(a3)
disp(a4)

%{
A1=sum(h1,2);
a1=length(A1)/m1/n1;
A2=sum(h2,2);
a2=length(A2)/m2/n2;
A3=sum(h3,2);
a3=length(A3)/m3/n3;
disp(a1)
disp(a2)
disp(a3)
%}
