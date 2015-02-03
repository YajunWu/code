function varargout = index(varargin)
% INDEX M-file for index.fig
%      INDEX, by itself, creates a new INDEX or raises the existing
%      singleton*.
%
%      H = INDEX returns the handle to a new INDEX or the handle to
%      the existing singleton*.
%
%      INDEX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INDEX.M with the given input arguments.
%
%      INDEX('Property','Value',...) creates a new INDEX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before index_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to index_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help index

% Last Modified by GUIDE v2.5 01-Feb-2015 22:00:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @index_OpeningFcn, ...
                   'gui_OutputFcn',  @index_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before index is made visible.
function index_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to index (see VARARGIN)

% Choose default command line output for index
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes index wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = index_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
muban=get(handles.edit1,'String');
src=get(handles.edit2,'String');
axes(handles.axes1);
[A,map]=imread(muban);
imshow(A,map);
axes(handles.axes2);
[A,map]=imread(src);
imshow(A,map);
grid on;
set(handles.text4,'string','    请检测...');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
muban=get(handles.edit1,'String');
src=get(handles.edit2,'String');
img0=imread(muban);
img=imread(src);
[m,n,g]=size(img);

status=0;%0无，1倾倒，2颠倒，3正常
jianceresult=strcat('    请检测...',10,'    色调直方图法检测互感器位置特征...');
disp(jianceresult);
set(handles.text4,'string',jianceresult);
bg = imcrop(img,[5,5,4,4]);
hu = imcrop(img,[20,100,n-40,m-200]);
%箱子的色度
bg_hsi=rgb2hsi(bg);
bg_h=bg_hsi(:,:,1);
avg_h=sum(bg_h(:))/25;

low_h=avg_h-0.2;
hight_h=avg_h+0.2;
%互感器图像色度
hu_hsi=rgb2hsi(hu);
hu_h=hu_hsi(:, :, 1);

axes(handles.axes3);
hist(hu_h)

bgnum = find(hu_h>low_h & hu_h< hight_h);
imgsize=length(hu_h(:,1))*length(hu_h(1,:));
sediaopercent = length(bgnum)/imgsize;
sediaopercent=roundn(sediaopercent,-2);

fengnum=0;
for i=1:5
    bgnum = find(hu_h>(i-1)/5 & hu_h< i/5);
    if length(bgnum)/imgsize>0.3
        fengnum=fengnum+1;
    end
end
set(handles.text55,'string',fengnum);
set(handles.text45,'string',sediaopercent);

if sediaopercent>0.9
    jianceresult=strcat(jianceresult,10,'    ***没有互感器');
    status=0;
else
    if fengnum>1
        jianceresult=strcat(jianceresult,10,'    ***互感器可能倾倒');
        status=1;
    else
        jianceresult=strcat(jianceresult,10,'    ***互感器颠倒或正常');
        status=3;
    end
end
set(handles.text4,'string',jianceresult);

if status>0
    jianceresult=strcat(jianceresult,10,'    模板匹配法检测互感器位置特征...');
    set(handles.text4,'string',jianceresult);
    functionname='indexpi.m';
    functiondir=which(functionname);
    functiondir=functiondir(1:end-length(functionname));
    addpath([functiondir '/surf']);
    r1=WyjMatch(img0,hu);
    %{
    axes(handles.axes4);
    imshow(r1.img);hold on;
    for i=1:r1.pipei
        plot([r1.pos1(i,2) r1.pos2(i,2)+r1.width]',[r1.pos1(i,1) r1.pos2(i,1)]','-');
        plot([r1.pos1(i,2) r1.pos2(i,2)+r1.width]',[r1.pos1(i,1) r1.pos2(i,1)]','o');
    end
    %}
    set(handles.text47,'string',r1.key);
    set(handles.text57,'string',r1.pipei);
    set(handles.text49,'string',r1.zheng);
    set(handles.text51,'string',r1.fan);
    zheng=r1.zheng/r1.key;
    fan=r1.fan/r1.key;
    if r1.pipei/r1.key>0.2 
        if zheng>0.6 && fan<0.2
            status=3;
            jianceresult=strcat(jianceresult,10,'    ***互感器正常');
        else if r1.zheng<r1.fan && r1.fan>0.05
                jianceresult=strcat(jianceresult,10,'    ***互感器颠倒');
                status=2;
            else
                if status==1
                    jianceresult=strcat(jianceresult,10,'    ***互感器倾倒');
                else
                    jianceresult=strcat(jianceresult,10,'    ***互感器有可能倾倒');
                end
            end
        end
    else 
        if status==1
            jianceresult=strcat(jianceresult,10,'    ***互感器倾倒');
        else
            jianceresult=strcat(jianceresult,10,'    ***互感器有可能倾倒');
        end
    end
    set(handles.text4,'string',jianceresult);
end


if status==3
    jianceresult=strcat(jianceresult,10,'    字符识别...');
    set(handles.text4,'string',jianceresult);
    cropimg3=fenge(hu);
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
    chars='    *电流比为';
    axes(handles.axes4);
    for y=1:n-2
        if (ycharsum(y)>1)&(ycharsum(y+1)<=1)
            if i==1;
                temp=cropimg3(1:m , 1:y);

            else
                temp=cropimg3(1:m , borders:y);
            end
            [l,k]=find(temp==0);
            imin=min(l);
            imax=max(l);
            jmin=min(k);
            jmax=max(k);
            temp=temp(imin:imax,jmin:jmax);
            temp=imresize(temp,[16,16],'nearest');
            i=i+1;
            
            imshow(temp);
            hold on
            feature=charFeature(temp);
            if feature.feature(1)>0
                for j=1:size(feature.kdrect,1)
                    rectangle('Position',feature.kdrect(j,:),'LineWidth',3,'EdgeColor','r');
                end
            end
            x1=round(16/3)+1;
            x2=round(16*2/3)+1;
            y1=round(16/3)+1;
            y2=round(16*2/3)+1;
            plot([x1 x1],[1 n],'-');
            plot([x2 x2],[1 n],'-');
            plot([1 m], [y1 y1],'-');
            plot([1 m], [y2 y2],'-');
            
            set(handles.text14,'string',feature.feature(1));
            set(handles.text16,'string',feature.feature(10));
            set(handles.text18,'string',feature.feature(11));
            set(handles.text20,'string',feature.feature(12));
            set(handles.text22,'string',feature.feature(13));
            set(handles.text24,'string',feature.feature(2));
            set(handles.text26,'string',feature.feature(3));
            set(handles.text28,'string',feature.feature(4));
            set(handles.text30,'string',feature.feature(5));
            set(handles.text32,'string',feature.feature(6));
            set(handles.text34,'string',feature.feature(7));
            set(handles.text36,'string',feature.feature(8));
            set(handles.text38,'string',feature.feature(9));
            disp(feature.feature);
            
            %孔洞粗分类
            char=pipei(feature.feature);
            if char.flag==1
                jianceresult=strcat(jianceresult,10,'    *当前字符为',char.char);
                a=char.char;
                chars=strcat(chars,a(2:length(a)-1));
            else
                jianceresult=strcat(jianceresult,10,'    未识别出字符');
            end

            set(handles.text4,'string',jianceresult);
        end
        if (ycharsum(y)<=1)&(ycharsum(y+1)>1)
            borders = y;
        end


    end
    temp=cropimg3(1:m , borders:n);
    [l,k]=find(temp==0);
            imin=min(l);
            imax=max(l);
            jmin=min(k);
            jmax=max(k);
            temp=temp(imin:imax,jmin:jmax);
            temp=imresize(temp,[16,16],'nearest');
            imshow(temp);
            hold on
            feature=charFeature(temp);
            if feature.feature(1)>0
                for j=1:size(feature.kdrect,1)
                    rectangle('Position',feature.kdrect(j,:),'LineWidth',3,'EdgeColor','r');
                end
            end
            x1=round(16/3)+1;
            x2=round(16*2/3)+1;
            y1=round(16/3)+1;
            y2=round(16*2/3)+1;
            plot([x1 x1],[1 n],'-');
            plot([x2 x2],[1 n],'-');
            plot([1 m], [y1 y1],'-');
            plot([1 m], [y2 y2],'-');

            set(handles.text14,'string',feature.feature(1));
            set(handles.text16,'string',feature.feature(10));
            set(handles.text18,'string',feature.feature(11));
            set(handles.text20,'string',feature.feature(12));
            set(handles.text22,'string',feature.feature(13));
            set(handles.text24,'string',feature.feature(2));
            set(handles.text26,'string',feature.feature(3));
            set(handles.text28,'string',feature.feature(4));
            set(handles.text30,'string',feature.feature(5));
            set(handles.text32,'string',feature.feature(6));
            set(handles.text34,'string',feature.feature(7));
            set(handles.text36,'string',feature.feature(8));
            set(handles.text38,'string',feature.feature(9));
            disp(feature.feature);
            
            %孔洞粗分类
            char=pipei(feature.feature);
            if char.flag==1
                jianceresult=strcat(jianceresult,10,'    *当前字符为',char.char);
                a=char.char;
                chars=strcat(chars,a(2:length(a)-1));
            else
                jianceresult=strcat(jianceresult,10,'    未识别出字符');
            end

            set(handles.text4,'string',jianceresult);
    jianceresult=strcat(jianceresult,10,chars);
    set(handles.text4,'string',jianceresult);
end
