function result=WyjMatch(img1, img2)

I1=im2double(img1);
I2=im2double(img2);

% Get the Key Points
Options.upright=true;
Options.init_sample=4;
Options.tresh=0.0001;
Ipts1=OpenSurf(I1,Options);
Ipts2=OpenSurf(I2,Options);

% Put the landmark descriptors in a matrix
D1 = reshape([Ipts1.descriptor],64,[]);
D2 = reshape([Ipts2.descriptor],64,[]);

key=length(Ipts1);
% Find the best matches
err=zeros(1,key);
cor1=1:key;
cor2=1:key;

for i=1:key,
    distance=sum((D2-repmat(D1(:,i),[1 length(Ipts2)])).^2,1);
    [err(i),cor2(i)]=min(distance);
    
end

% Show both images
I = zeros([size(I1,1) size(I1,2)*2 size(I1,3)]);
I(:,1:size(I1,2),:)=I1; I(:,size(I1,2)+1:size(I1,2)+size(I2,2),:)=I2;

% Sort matches on vector distance
%{
[err, ind]=sort(err);
cor1=cor1(ind);
cor2=cor2(ind);
%}

pipei=0;

for i=1:key,
    if err(i)<0.12
        pipei=pipei+1;
        cor1(pipei)=cor1(i);
        cor2(pipei)=cor2(i);
    end
end

Pos1=[[Ipts1(cor1).y]',[Ipts1(cor1).x]'];
Pos2=[[Ipts2(cor2).y]',[Ipts2(cor2).x]'];
Pos1=Pos1(1:pipei,:);
Pos2=Pos2(1:pipei,:);
zheng_num=0;
fan_num=0;
for i=1:pipei%length(Ipts1),
  
        % Show the best matches
       % pipei_num=pipei_num+1;
      % plot([Pos1(i,2) Pos2(i,2)+size(I1,2)]',[Pos1(i,1) Pos2(i,1)]','-');
       %plot([Pos1(i,2) Pos2(i,2)+size(I1,2)]',[Pos1(i,1) Pos2(i,1)]','o');
        if abs(Pos1(i,2)-Pos2(i,2))<10 && abs(Pos1(i,1)-Pos2(i,1))<10
            zheng_num=zheng_num+1;
           
        else if abs(Pos1(i,2)+Pos2(i,2)-size(I1,2))<60 && abs(Pos1(i,1)+Pos2(i,1)-size(I1,1))<80
                fan_num=fan_num+1;
                
            end
        end
end

result.zheng=zheng_num;
result.fan=fan_num;
result.pipei=pipei;
result.key=key;
result.img=I;
result.width=size(I1,2);
result.pos1=Pos1;
result.pos2=Pos2;
