clc, close all, clear all
src = imread('E:\�������\��ҵ����\img\void1.jpg');
hu = imread('E:\�������\��ҵ����\code\hu_void.jpg');
bg = imcrop(src,[5,5,4,4]);

%���ӵ�ɫ��
bg_hsi=rgb2hsi(bg);
bg_h=bg_hsi(:,:,1);
avg_h=sum(bg_h(:))/25;

low_h=avg_h-0.2;
hight_h=avg_h+0.2;

%������ͼ��ɫ��
[m1,n1,g2]=size(hu);
hu_hsi=rgb2hsi(hu);
hu_h=hu_hsi(:, :, 1);
subplot(2,2,2);hist(hu_h)

aa = find(hu_h>low_h & hu_h< hight_h);
size=m1*n1;
bb = length(aa)/size;


if bb>0.9
    disp('�޻�����');
end
