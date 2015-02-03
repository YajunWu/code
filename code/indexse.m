function varargout = indexse(varargin)
% INDEXSE M-file for indexse.fig
%      INDEXSE, by itself, creates a new INDEXSE or raises the existing
%      singleton*.
%
%      H = INDEXSE returns the handle to a new INDEXSE or the handle to
%      the existing singleton*.
%
%      INDEXSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INDEXSE.M with the given input arguments.
%
%      INDEXSE('Property','Value',...) creates a new INDEXSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before indexse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to indexse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help indexse

% Last Modified by GUIDE v2.5 30-Jan-2015 22:09:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @indexse_OpeningFcn, ...
                   'gui_OutputFcn',  @indexse_OutputFcn, ...
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


% --- Executes just before indexse is made visible.
function indexse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to indexse (see VARARGIN)

% Choose default command line output for indexse
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes indexse wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = indexse_OutputFcn(hObject, eventdata, handles) 
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



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
src=get(handles.edit2,'String');
axes(handles.axes2);
imshow(src)
img=imread(src);
[m,n,g]=size(img);

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
hist(hu_h);
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
set(handles.text61,'string',fengnum);
set(handles.text58,'string',sediaopercent);

if sediaopercent>0.9
    disp(sediaopercent);
    set(handles.text4,'string','  被检测图像中没有互感器');
else
    if fengnum>1
        set(handles.text4,'string','  被检测图像中有互感器，互感器可能倾倒');
    else
        set(handles.text4,'string','  被检测图像中有互感器，互感器可能正常或颠倒');
    end
end




gray=rgb2gray(hu);
threshold = graythresh(gray);
binary = ~im2bw(gray,threshold);
