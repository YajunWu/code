
clc, close all, clear all;
hu = imread('E:\论文相关\毕业论文\img\void1.jpg');
[m,n,g]=size(hu);
bg = imcrop(hu,[5,5,4,4]);
hu = imcrop(hu,[20,100,n-40,m-200]);

%箱子的色度
bg_hsi=rgb2hsi(bg);
bg_h=bg_hsi(:,:,1);
avg_h=sum(bg_h(:))/25;

low_h=avg_h-0.2;
hight_h=avg_h+0.2;

%互感器图像色度
hu_hsi=rgb2hsi(hu);
hu_h=hu_hsi(:, :, 1);

aa = find(hu_h>low_h & hu_h< hight_h);
imgsize=length(hu_h(:,1))*length(hu_h(1,:));
bb = length(aa)/imgsize;

sediao.percent=bb;
sediao.img=hu;
disp(sediao)
