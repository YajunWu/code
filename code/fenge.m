function charimgs=fenge(img)
[m,n,g]=size(img);
figure

hu=im2double(img);
hu=imadjust(hu,[0.3;0.7],[]);

for x=1:m-1
    for y=1:n-1
        r=hu(x,y,1);
        g=hu(x,y,2);
        b=hu(x,y,3);
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
            hu(x,y,3)=0;
            hu(x,y,2)=0;
            hu(x,y,1)=0;
        end
    end
end

gray=rgb2gray(hu);
gray = medfilt2(gray,[5,5]);
threshold = graythresh(gray);
binary = ~im2bw(gray,threshold);
subplot(1,3,1),imshow(binary),xlabel('二值化图像');


%截取文字部分
%初步定位 横向定位
[m,n]=size(binary);
rectsy=0;
rectey=0;
temp=0;
for  y=1:n
    tempy = 0;
    for x=1:m
        if binary(x,y)==0;
            tempy = tempy + 1;
        end
    end
    if tempy > m/10 && tempy < m/2;
        rectey = y;
        if rectsy==0
            temp=temp+1;
            rectsy = y;
        end
    else if tempy<4 && temp<2
            rectsy=0;
        end
    end
end
rectwidth = rectey-rectsy;
cropimg = imcrop(binary, [rectsy, 0, rectwidth, m]);
subplot(1,3,2),imshow(cropimg),xlabel('铭牌横向定位');

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
cropi=imcrop(cropimg, [0, rectsx, n, rectex-rectsx]);
subplot(1,3,3),imshow(cropi),xlabel('铭牌纵向定位');
gray=rgb2gray(hu);
threshold = graythresh(gray);
binary = ~im2bw(gray,threshold);
binary=imcrop(binary, [rectsy, rectsx, rectey-rectsy, rectex-rectsx]);


figure
%精确定位 纵向定位
[m,n]=size(binary);
rectmargins=0;
rectmargine=0;
rectmargin=0;
for  x=1:m
    tempx = 0;
    for y=1:n
        if binary(x,y)==0;
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
cropimg2 = imcrop(binary, [0, rectmargine, n, rectmargins-rectmargine]);
subplot(1,2,1),imshow(cropimg2),xlabel('字符区域定位1');

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
charimgs=cropimg3;
subplot(1,2,2),imshow(cropimg3),xlabel('字符区域定位2');
%{
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
%{
y=1:n-1;
figure(2)
plot(y,ycharsum)%画出y方向上的像素分布
%}

%找出ysum分布的几个与y轴交点就是单个字符在y轴上分布的区间
i=1;j=1;
borders=0;
figure

for y=1:n-2
    if (ycharsum(y)>1)&(ycharsum(y+1)<=1)
        if i==1;
            subplot(3,3,1); imshow(cropimg3(1:m , 1:y));
            temp=cropimg3(1:m , 1:y);
            
        else
            subplot(3,3,i); imshow(cropimg3(1:m , borders:y));
            temp=cropimg3(1:m , borders:y);
        end
        temp=imresize(temp,[16,16],'nearest');
        charimgs.imgs(i,:)=temp;
        i=i+1;
    end
    if (ycharsum(y)<=1)&(ycharsum(y+1)>1)
        borders = y;
    end
    
    
end
subplot(3,3,i); imshow(cropimg3(1:m , borders:n));
temp=cropimg3(1:m , borders:n);
temp=imresize(temp,[16,16],'nearest');
charimgs.imgs(i,:)=temp;
%}