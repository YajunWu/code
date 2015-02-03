function charResult=charFeature(img)
%figure,imshow(img),hold on
%孔洞
info=regionprops(img,'BoundingBox');
[m,n]=size(img);
kd=0;%孔洞
for i=1:length(info)
    rect=info(i).BoundingBox;
   % if img(floor(rect(1)+rect(3)/2),floor(rect(2)+rect(4)/2))==1
    if floor(rect(1))==0 || floor(rect(1)+rect(3))>m-1 || floor(rect(2))==0 || floor(rect(2)+rect(4))>n-1
       
    else
        %rectangle('Position',rect,'LineWidth',3,'EdgeColor','r');
        kd=kd+1;
        kdrect(kd,:)=rect;
    end
   % end
end
if kd>0
charResult.kdrect=kdrect;
end
charResult.feature(1)=kd;

%均匀网格
grid1=0;
grid2=0;
grid3=0;
grid4=0;
grid5=0;
grid6=0;
grid7=0;
grid8=0;
midy=n/2;
x1=m/4;
x2=m/2;
x3=x1*3;
for x=1:m
    for y=1:n
        if x<x1+1&&y<midy+1&&img(x,y)==0
            grid1=grid1+1;
        end
        if x<x1+1&&y>midy&&img(x,y)==0
            grid2=grid2+1;
        end
        if x<x2+1&&x>x1&&y<midy+1&&img(x,y)==0
            grid3=grid3+1;
        end
        if x<x2+1&&x>x1&&y>midy&&img(x,y)==0
            grid4=grid4+1;
        end
        if x<x3+1&&x>x2&&y<midy+1&&img(x,y)==0
            grid5=grid5+1;
        end
        if x<x3+1&&x>x2&&y>midy&&img(x,y)==0
            grid6=grid6+1;
        end
        if x>x3&&y<midy+1&&img(x,y)==0
            grid7=grid7+1;
        end
        if x>x3&&y>midy&&img(x,y)==0
            grid8=grid8+1;
        end
    end
end
charResult.feature(2)=grid1;
charResult.feature(3)=grid2;
charResult.feature(4)=grid3;
charResult.feature(5)=grid4;
charResult.feature(6)=grid5;
charResult.feature(7)=grid6;
charResult.feature(8)=grid7;
charResult.feature(9)=grid8;

%交叉点特性
x1=round(m/3)+1;
x2=round(m*2/3)+1;
y1=round(n/3)+1;
y2=round(n*2/3)+1;
h1=0;
h2=0;
v1=0;
v2=0;
%{
plot([x1 x1],[1 n],'-');
plot([x2 x2],[1 n],'-');
plot([1 m], [y1 y1],'-');
plot([1 m], [y2 y2],'-');
%}
flag1=0;
flag2=0;
for y=1:n
    if img(x1,y)==0
        if flag1==0
            h1=h1+1;
            flag1=1;
        end
    else
        flag1=0;
    end
    if img(x2,y)==0
        if flag2==0
            h2=h2+1;
            flag2=1;
        end
    else
        flag2=0;
    end
end
flag1=0;
flag2=0;
for x=1:m
    if img(x,y1)==0
        if flag1==0
            v1=v1+1;
            flag1=1;
        end
    else
        flag1=0;
    end
    if img(x,y2)==0
        if flag2==0
            v2=v2+1;
            flag2=1;
        end
    else
        flag2=0;
    end
end
charResult.feature(10)=h1;
charResult.feature(11)=h2;
charResult.feature(12)=v1;
charResult.feature(13)=v2;

%总字符像素个数
charResult.feature(14)=grid1+grid2+grid3+grid4+grid5+grid6+grid7+grid8;

