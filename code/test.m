% Clear all
clc, close all, clear all
% Read image
src=imread('E:\projects\���𻥸��������Ŀ\��Ŀ�����������������ʶ��\����ͼ��\up1.jpg');
% Show image
imwrite(src, 'src.jpg');
%imshow(src);title('INPUT IMAGE WITH NOISE')

% Convert to gray scale
if size(src,3)==3 %RGB image
    gray=rgb2gray(src);
    imwrite(gray, 'gray.jpg');
    %imshow(gray);
end

% Convert to BW
threshold = graythresh(gray);
binary = ~im2bw(gray,threshold);
imwrite(binary, 'binary.jpg');
%figure(2),imshow(binary);


%��ȡ���ֲ���
%������λ ����λ
[m,n]=size(binary);
rectsx=0;rectsy=0;
rectex=0;rectey=0;
for  y=1:n
    tempy = 0;
    for x=1:m
        if binary(x,y)==0;
            tempy = tempy + 1;
        end
    end
    if tempy > m/4 && tempy < m*3/4;
        rectey = y;
        if rectsy == 0
            rectsy = y;
        end
    end
end
rectwidth = rectey-rectsy;
cropimg = imcrop(binary, [rectsy, 0, rectwidth, m]);
imwrite(cropimg,'����λ1.jpg');

[m,n]=size(cropimg);
rectmargin = 0;
rectmargins=0;
for  y=1:n
    tempy = 0;
    for x=1:m
        if cropimg(x,y)==0;
            tempy = tempy + 1;
        end
    end
    if tempy < 8;
        if rectmargins ==0;
            rectmargins = y;
        end
       
    else
        if rectmargins> 0 && (y-rectmargins)> 10;
            rectmargin = y;
            break;
        end
        
    end
end
cropimg4 = imcrop(cropimg, [rectmargin, 0, n, m]);
imwrite(cropimg4,'����λ2.jpg');

%������λ ����λ
[m,n]=size(cropimg);
for  x=1:m
    tempx = 0;
    for y=1:n
        if cropimg(x,y)==0;
            tempx = tempx + 1;
        end
    end
    if (tempx > n*1/6) && (tempx < n*2/3);
        rectex = x;
        if rectsx == 0
            rectsx = x;
        
        end
    else if rectsx > 0 && (rectex - rectsx) < 2;
            rectsx = 0;
        end
    end 
    
end
cropimg1 = imcrop(cropimg4, [0, rectsx, n, rectex-rectsx]);
imwrite(cropimg1, '���������λ.jpg');
%figure; imshow(cropimg);


%��ȷ��λ ����λ
[m,n]=size(cropimg1);
rectmargins=0;
rectmargine=0;
rectmargin=0;
for  x=1:m
    tempx = 0;
    for y=1:n
        if cropimg1(x,y)==0;
            tempx = tempx + 1;
        end
    end
    if tempx < 4;
        if rectmargin < 5 && mod(rectmargin, 2)==0;
            rectmargin = rectmargin + 1;
            rectmargins = x;
        end
    else
        if mod(rectmargin,2) == 1 && rectmargin < 5;
            if(x - rectmargins) > 2 && (x - rectmargins)<10;
                rectmargin =rectmargin + 1;
                rectmargine = x;
            else
                rectmargin =rectmargin - 1;
            end
        else if(rectmargin == 5)
                if(x - rectmargins) > 2 && (x - rectmargins)<10;
                    break;
                else
                    rectmargin =rectmargin - 1;
                end
            end
        end
    end 
end
cropimg2 = imcrop(cropimg1, [0, m-24, n, 20]);
imwrite(cropimg2, '����ȷ��λ.jpg');

%��ȷ��λ ����λ
[m,n]=size(cropimg2);
rectmargins=0;
rectmargine=0;
rectmargin=0;
for  y=1:n
    tempy = 0;
    for x=1:m
        if cropimg2(x,y)==0;
            tempy = tempy + 1;
        end
    end
    if tempy > m*2/3;
        if rectmargin < 3 && mod(rectmargin, 2)==0;
            rectmargin = rectmargin + 1;
            rectmargins = y;
        end
    else
        if rectmargin == 1;
            if (y - rectmargins) > 10;
                    rectmargin =rectmargin + 1;
                    rectmargine = y;
            else
                 rectmargin =rectmargin - 1;
            end
        else if rectmargin == 3;
                if (y - rectmargins) > 20 ;
                    break;
                else
                    rectmargin =rectmargin - 1;
                end
            end
        end
    end 
end
cropimg3 = imcrop(cropimg2, [rectmargine, 0, rectmargins-rectmargine, m]);
imwrite(cropimg3, '����ȷ��λ.jpg');

subplot(2,4,1); imshow(src);title('ԭͼ');
subplot(2,4,2); imshow(gray);title('�Ҷ�ͼ');
subplot(2,4,3); imshow(binary);title('��ֵ��ͼ');
subplot(2,4,4); imshow(cropimg);title('����λͼ');
subplot(2,4,5); imshow(cropimg4);title('����λͼ');
subplot(2,4,6); imshow(cropimg1);title('����λͼ');
subplot(2,4,7); imshow(cropimg2);title('��ȷ��λͼ');
subplot(2,4,8); imshow(cropimg3);title('��ȷ��λͼ');

%�ָ��ַ�
[m,n]=size(cropimg3);
ycharsum(n-1)=0;
for y=1:n-1
    tempy = 0;
    for x=1:m
        if cropimg3(x,y)==1;
            tempy = tempy + 1;
        end
    end
    ycharsum(y)=tempy;
end
y=1:n-1;
figure(2)
plot(y,ycharsum)%����y�����ϵ����طֲ�


%�ҳ�ysum�ֲ��ļ�����y�ύ����ǵ����ַ���y���Ϸֲ�������
i=0;j=1;
borders=1;
figure(3)
for y=1:n-2
    if (ycharsum(y)>1)&(ycharsum(y+1)<=1)
        charfile=sprintf('%d%s',i,'.bmp');
        if i==0;
            subplot(4,6,1); imshow(cropimg3(1:m , 1:y));
            
            imwrite(cropimg3(1:m , 1:y), charfile);
        else
            subplot(4,6,i+1); imshow(cropimg3(1:m , borders:y));
            imwrite(cropimg3(1:m , borders:y), charfile);
        end
        i=i+1;
    end
    if (ycharsum(y)<=1)&(ycharsum(y+1)>1)
        borders = y;
    end
    
    
end
subplot(4,6,i+1); imshow(cropimg3(1:m , borders:n));
charfile=sprintf('%d%s',i,'.bmp');
imwrite(cropimg3(1:m , borders:n), charfile);

figure(4);
charnum = i+1;
for kk = 0:charnum-1
    p1=ones(16,16);
    m=strcat(int2str(kk),'.bmp');
    x=imread(m,'bmp');


    [i,j]=find(x==0);
    imin=min(i);
    imax=max(i);
    jmin=min(j);
    jmax=max(j);
    bw1=x(imin:imax,jmin:jmax);%words segmentation
    
    bw1=imresize(bw1,[16,16],'nearest');
    m=strcat('num',int2str(kk),'.bmp')
    imwrite(bw1,m)
    subplot(4,6,kk+1); imshow(bw1);
    
    
end

% ������ѵ��BP���� 
pr(1:256,1)=0;
pr(1:256,2)=1;
net=newff(pr,[25 1],{'logsig' 'purelin'}, 'traingdx', 'learngdm');
net.trainParam.epochs=250;
net.trainParam.goal=0.001;
net.trainParam.show=10;
net.trainParam.lr=0.05;
net=train(net,p,t)


save E52net net;

%{
%��canny����ʶ��ǿ��ͼ���еı߽� 
edge =edge(binary,'canny');
%���ͼ���Ե
figure(3),imshow(edge);title('ͼ���Ե��ȡ');
bg1=imclose(edge,strel('rectangle',[8,8]));%ȡ���ο�ı����� 
figure,imshow(bg1);title('ͼ�������[5,8]');%����������ͼ�� 
bg3=imopen(bg1,strel('rectangle',[8,8]));%ȡ���ο�Ŀ�����
figure,imshow(bg3);title('ͼ������[5,8]');%����������ͼ�� 
bg2=imclose(bg3,strel('rectangle',[19,1]));%ȡ���ο�Ŀ����� 
figure,imshow(bg2);title('ͼ������[19,1]');%����������ͼ��
%}