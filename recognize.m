clc;
clear all;
close all;

%{
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
            t(kk+1)=0;
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
            t(kk+1)=10;
        case{11}
            t(kk+1)=11;
    end
end

% ´´½¨ºÍÑµÁ·BPÍøÂç 
pr(1:256,1)=0;
pr(1:256,2)=1;
net=newff(pr,[25 1],{'logsig' 'purelin'}, 'traingdx', 'learngdm');
net.trainParam.epochs=250;
net.trainParam.goal=0.001;
net.trainParam.show=10;
net.trainParam.lr=0.05;
net=train(net,p,t);

save E52net net;
%}
Rchar=['0','0','0','0','0','0','0'];
for kk = 0:6
    p(1:256,1)=1;
    p1=ones(16,16);
    load E52net net;
    
    %{
    m=strcat('num',int2str(kk),'.bmp');
    x=imread(m,'bmp');
    
    [i,j]=find(x==0);
    imin=min(i);
    imax=max(i);
    jmin=min(j);
    jmax=max(j);
    bw1=x(imin:imax,jmin:jmax);%words segmentation
    
    bw1=imresize(bw1,[16,16],'nearest');
    m=strcat('num',int2str(kk),'.bmp');
    imwrite(bw1,m)
    subplot(3,3,kk+1); imshow(bw1);
    %}
    m=strcat('num',int2str(kk),'.bmp');
    bw1=imread(m,'bmp');
     [i,j]=size(bw1);
    i1=round((16-i)/2);
    j1=round((16-j)/2);
    p1(i1+1:i1+i,j1+1:j1+j)=bw1;
    
    for m=0:15
        p(m*16+1:(m+1)*16,1)=p1(1:16,m+1);
    end
    [a,Pf,Af]=sim(net,p);

    a=round(a);
    disp(a);
    switch a
        case 0
            Rchar(kk+1)='0';
            
        case 1
            Rchar(kk+1)='1';
            
        case 2
            Rchar(kk+1)='2';
            
        case 3
            Rchar(kk+1)='3';
            
        case 4
            Rchar(kk+1)='4';
            
        case 5
            Rchar(kk+1)='5';
            
        case 6
            Rchar(kk+1)='6';
            
        case 7
            Rchar(kk+1)='7';
            
        case 8
            Rchar(kk+1)='8';
            
        case 9
            Rchar(kk+1)='9';
            
        case 10
            Rchar(kk+1)='A';
            
        case 11
            Rchar(kk+1)='/';
            
         otherwise 
            Rchar(kk+1)='false';
            
    end
    
end

disp(Rchar)