function char=pipei(feature)
%�׶��ַ���
mubanchars=importdata('chars.txt');
chartag=mubanchars.textdata;
chardata=mubanchars.data;
mubannum=length(chartag);
D=400;
index1=1;
for i=1:mubannum
    if feature(1)==chardata(i,1)
        D1=(feature(2)-chardata(i,2))^2+(feature(3)-chardata(i,3))^2+(feature(4)-chardata(i,4))^2+(feature(5)-chardata(i,5))^2+(feature(6)-chardata(i,6))^2+(feature(7)-chardata(i,7))^2+(feature(8)-chardata(i,8))^2+(feature(9)-chardata(i,9))^2;
        if D1<D
            D=D1;
            index=i;
        end
    end
end
D=(feature(10)-chardata(i,10))^2+(feature(11)-chardata(i,11))^2+(feature(12)-chardata(i,12))^2+(feature(13)-chardata(i,13))^2;

if D<30
    char.flag=1;
    temp=chartag(index);
    char.char=temp{1};
else 
    char.flag=0;
    %{
    feature1=feature;
    if feature1(1)>0
        feature1(1)=feature1(1)-1;
    else
        feature1(1)=1;
    end
    pipei(feature1)
    %}
end