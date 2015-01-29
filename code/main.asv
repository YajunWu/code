% Clear all
clc, close all, clear all
% Read image
src=imread('E:\projects\南瑞互感器相关项目\项目——互感器外观智能识别\可用图像\up1.jpg');
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


%截取文字部分
%初步定位 横向定位
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
imwrite(cropimg,'横向定位1.jpg');

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
imwrite(cropimg4,'横向定位2.jpg');

%初步定位 纵向定位
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
imwrite(cropimg1, '纵向基本定位.jpg');
%figure; imshow(cropimg);


%精确定位 纵向定位
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
cropimg2 = imcrop(cropimg1, [0, rectmargine, n, rectmargins-rectmargine]);
imwrite(cropimg2, '纵向精确定位.jpg');

%精确定位 横向定位
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
    if tempy < 2;
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
                if (y - rectmargins) > 10 ;
                    break;
                else
                    rectmargin =rectmargin - 1;
                end
            end
        end
    end 
end
disp(rectmargins);
disp(rectmargine)
cropimg3 = imcrop(cropimg2, [rectmargine, 0, rectmargins-rectmargine, m]);
imwrite(cropimg3, '横向精确定位.jpg');

subplot(2,4,1); imshow(src);title('原图');
subplot(2,4,2); imshow(gray);title('灰度图');
subplot(2,4,3); imshow(binary);title('二值化图');
subplot(2,4,4); imshow(cropimg);title('横向定位图');
subplot(2,4,5); imshow(cropimg4);title('横向定位图');
subplot(2,4,6); imshow(cropimg1);title('纵向定位图');
subplot(2,4,7); imshow(cropimg2);title('精确定位图');
subplot(2,4,8); imshow(cropimg3);title('精确定位图');

%分割字符
[m,n]=size(cropimg3);
ycharsum(n-1)=0;
for y=1:n-1
    tempy = 0;
    for x=1:m
        if cropimg3(x,y)==0;
            tempy = tempy + 1;
        end
    end
    ycharsum(y)=tempy;
end
y=1:n-1;
figure(2)
plot(y,ycharsum)%画出y方向上的像素分布


%找出ysum分布的几个与y轴交点就是单个字符在y轴上分布的区间
i=0;j=1;
borders=0;
figure(3)
for y=1:n-2
    if (ycharsum(y)>1)&(ycharsum(y+1)<=1)
        charfile=sprintf('%d%s',i,'.bmp');
        if i==0;
            subplot(3,3,1); imshow(cropimg3(1:m , 1:y));
            
            imwrite(cropimg3(1:m , 1:y), charfile);
        else
            subplot(3,3,i+1); imshow(cropimg3(1:m , borders:y));
            imwrite(cropimg3(1:m , borders:y), charfile);
        end
        i=i+1;
    end
    if (ycharsum(y)<=1)&(ycharsum(y+1)>1)
        borders = y;
    end
    
    
end
subplot(3,3,i+1); imshow(cropimg3(1:m , borders:n));
charfile=sprintf('%d%s',i,'.bmp');
imwrite(cropimg3(1:m , borders:n), charfile);



figure(4);
charnum = i+1;
for kk = 0:12
    p1=ones(16,16);
    m=strcat('numbers\',int2str(kk),'.bmp');
    x=imread(m,'bmp');


    [i,j]=find(x==1);
    imin=min(i);
    imax=max(i);
    jmin=min(j);
    jmax=max(j);
    bw1=x(imin:imax,jmin:jmax);%words segmentation
    
    bw1=imresize(bw1,[16,16],'nearest');
    [i,j]=size(bw1);
    i1=round((16-i)/2);
    j1=round((16-j)/2);
    p1(i1+1:i1+i,j1+1:j1+j)=bw1;
    
    for m=0:15
        p(m*16+1:(m+1)*16,kk+1)=p1(1:16,m+1);
    end
    
    switch kk
        case{0,8}
            t(kk+1)=1;
        case{1}
            t(kk+1)=1;
        case{2}
            t(kk+1)=2;
        case{3}
            t(kk+1)=3;
        case{4,12}
            t(kk+1)=4;
        case{5}
            t(kk+1)=5;
        case{6}
            t(kk+1)=6;
        case{7}
            t(kk+1)=7;
        case{9}
            t(kk+1)=9;
        case{10}
            t(kk+1)='A';
        case{11}
            t(kk+1)='/';
    end
end

% 创建和训练BP网络 
pr(1:256,1)=0;
pr(1:256,2)=1;
net=newff(pr,[25 1],{'logsig' 'purelin'}, 'traingdx', 'learngdm');
net.trainParam.epochs=250;
net.trainParam.goal=0.001;
net.trainParam.show=10;
net.trainParam.lr=0.05;
net=train(net,p,t);


save E52net net;

for kk = 0:charnum-1
     p(1:256,1)=1;
    p1=ones(16,16);
    load E52net net;
    
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
    subplot(3,3,kk+1); imshow(bw1);
     [i,j]=size(bw1);
    i1=round((16-i)/2);
    j1=round((16-j)/2);
    p1(i1+1:i1+i,j1+1:j1+j)=bw1;
    
    for m=0:15
        p(m*16+1:(m+1)*16,1)=p1(1:16,m+1);
    end
    [a,Pf,Af]=sim(net,p);
    disp(p)
    disp(a)
    figure;imshow(p1);
    a=round(a)
    
        switch a(1)
            case 0
                Rchar(i)='0'
                break
            case 1
                Rchar(i)='1'
                break
            case 2
                Rchar(i)='2'
                break
            case 3
                Rchar(i)='3'
                break
            case 4
                Rchar(i)='4'
                break
            case 5
                Rchar(i)='5'
                break
            case 6
               Rchar(i)='A'
                break
            case 7
               Rchar(i)='B'
                break
            case 8
                Rchar(i)='C'
                break
            case 9
               Rchar(i)='D'
                break
            case 10
               Rchar(i)='E'
                break
             otherwise 
                Rchar(i)='false'   
                break;
        end
    disp(Rchar)
end

 schar=[Rchar(1),Rchar(2),Rchar(3),Rchar(4)]

%{
%用canny算子识别强度图像中的边界 
edge =edge(binary,'canny');
%输出图像边缘
figure(3),imshow(edge);title('图像边缘提取');
bg1=imclose(edge,strel('rectangle',[8,8]));%取矩形框的闭运算 
figure,imshow(bg1);title('图像闭运算[5,8]');%输出闭运算的图像 
bg3=imopen(bg1,strel('rectangle',[8,8]));%取矩形框的开运算
figure,imshow(bg3);title('图像开运算[5,8]');%输出开运算的图像 
bg2=imclose(bg3,strel('rectangle',[19,1]));%取矩形框的开运算 
figure,imshow(bg2);title('图像开运算[19,1]');%输出开运算的图像
%}