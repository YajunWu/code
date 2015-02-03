function varargout = index1(varargin)
% INDEX1 M-file for index1.fig
%      INDEX1, by itself, creates a new INDEX1 or raises the existing
%      singleton*.
%
%      H = INDEX1 returns the handle to a new INDEX1 or the handle to
%      the existing singleton*.
%
%      INDEX1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INDEX1.M with the given input arguments.
%
%      INDEX1('Property','Value',...) creates a new INDEX1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before index1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to index1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help index1

% Last Modified by GUIDE v2.5 01-Feb-2015 19:05:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @index1_OpeningFcn, ...
                   'gui_OutputFcn',  @index1_OutputFcn, ...
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


% --- Executes just before index1 is made visible.
function index1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to index1 (see VARARGIN)

% Choose default command line output for index1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes index1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = index1_OutputFcn(hObject, eventdata, handles) 
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



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)]
src=get(handles.edit2,'String');
axes(handles.axes4)
img0=imread(src);
[m,n]=size(img0);
imshow(img0);
axes(handles.axes7)
img1=img0;
imshow(img1);
hold on
feature=charFeature(img1);
if feature.feature(1)>0
    for i=1:size(feature.kdrect,1)
        rectangle('Position',feature.kdrect(i,:),'LineWidth',3,'EdgeColor','r');
    end
end
x1=round(m/3)+1;
x2=round(m*2/3)+1;
y1=round(n/3)+1;
y2=round(n*2/3)+1;
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

%孔洞粗分类
char=pipei(feature.feature);

if char.flag==1
    info='  当前字符为';
    info=strcat(info,char.char);
    disp(info)
else
    info='  未识别出字符';
end
set(handles.text4,'string',info);
