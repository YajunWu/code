clc, close all, clear all

%{
figure;
src_ok=imread('E:\论文相关\毕业论文\code\hu_zhengmian.jpg');
subplot(2,2,1);imshow(src_ok);title('原图像');
[m_ok,n_ok,g_ok]=size(src_ok);


hu_ok=im2double(src_ok);
%hu_ok=imadjust(src_ok,[0.3;0.7],[]);
%hu_ok=imadjust(hu_ok,[0.3;0.7],[]);

for x=1:m_ok-1
    for y=1:n_ok-1
        if hu_ok(x,y,3)>(hu_ok(x,y,2)+12)&& hu_ok(x,y,3)>(hu_ok(x,y,1)+32)
            hu_ok(x,y,3)=0;
            hu_ok(x,y,2)=0;
            hu_ok(x,y,1)=0;
        end
    end
end

%{
for x=1:m_ok-1
    for y=1:n_ok-1
        r=hu_ok(x,y,1);
        g=hu_ok(x,y,2);
        b=hu_ok(x,y,3);
        num = 0.5*((r - g) + (r - b));
        den = sqrt((r - g).^2 + (r - b).*(g - b));
        theta = acos(num./(den + eps));
        H = theta;
        H(b > g) = 2*pi - H(b > g);
        H = H/(2*pi);
        num = min(min(r, g), b);
        den = r + g + b;
        den(den == 0) = eps;
        S = 1 - 3.* num./den;
        H(S == 0) = 0;
        if H>0.44 && H<0.64
            hu_ok(x,y,3)=0;
            hu_ok(x,y,2)=0;
            hu_ok(x,y,1)=0;
        end
    end
end
%}
subplot(2,2,2);imshow(hu_ok);title('灰度图像');
gray_ok=rgb2gray(hu_ok);
gray_ok = medfilt2(gray_ok,[3,3]);
subplot(2,2,3);imshow(gray_ok);title('灰度图像');
threshold_ok = graythresh(gray_ok);
binary_ok = ~im2bw(gray_ok,threshold_ok);
subplot(2,2,4);imshow(binary_ok);title('二值图像');
%}
binary_ok=imread('E:\论文相关\毕业论文\code\hu_ok_binary.jpg');
figure
%截取文字部分
%初步定位 横向定位
[m,n]=size(binary_ok);
rectsx=0;rectsy=0;
rectex=0;rectey=0;
for  y=1:n
    tempy = 0;
    for x=1:m
        if binary_ok(x,y)==0;
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
cropimg = imcrop(binary_ok, [rectsy, 0, rectwidth, m]);
subplot(2,2,1),imshow(cropimg),title('横向定位1');



%初步定位 纵向定位
rectsx = 0;
rectex = 0;
[m,n]=size(cropimg);
for  x=1:m
    tempx = 0;
    for y=1:n
        if cropimg(x,y)==0;
            tempx = tempx + 1;
        end
    end
    if (tempx > 5) && (tempx < n*2/3);
        rectex = x;
        if rectsx == 0
            rectsx = x;
        
        end
   
    end 
    
end
cropimg1 = imcrop(cropimg, [0, rectsx, n, rectex-rectsx]);
subplot(2,2,2),imshow(cropimg1),title('纵向定位1');
imwrite(cropimg1,'mingpai.jpg');

