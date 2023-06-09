function varargout = ProjectGUI(varargin)
% PROJECTGUI MATLAB code for ProjectGUI.fig
%      PROJECTGUI, by itself, creates a new PROJECTGUI or raises the existing
%      singleton*.
%
%      H = PROJECTGUI returns the handle to a new PROJECTGUI or the handle to
%      the existing singleton*.
%
%      PROJECTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTGUI.M with the given input arguments.
%
%      PROJECTGUI('Property','Value',...) creates a new PROJECTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProjectGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProjectGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProjectGUI

% Last Modified by GUIDE v2.5 08-Jun-2023 21:15:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectGUI_OutputFcn, ...
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


% --- Executes just before ProjectGUI is made visible.
function ProjectGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProjectGUI (see VARARGIN)

% Choose default command line output for ProjectGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProjectGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.Image);
background = imread('Cancer.jpg');
axis off;
imshow(background);


% --- Outputs from this function are returned to the command line.
function varargout = ProjectGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in DiagnoseBtn.
function DiagnoseBtn_Callback(hObject, eventdata, handles)
% hObject    handle to DiagnoseBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('variablesNN.mat');
p_test = [str2double(get(handles.radius, 'String')) / 30;
     str2double(get(handles.texture, 'String')) / 40;
     str2double(get(handles.perimeter, 'String')) /190;
     str2double(get(handles.area, 'String')) / 2500;
     str2double(get(handles.smooth, 'String')) * 5;
     str2double(get(handles.compact, 'String')) * 3;
     str2double(get(handles.concavity, 'String')) * 2;
     str2double(get(handles.concave, 'String')) * 5;
     str2double(get(handles.simmetry, 'String')) * 3;
     str2double(get(handles.fractal, 'String')) * 10;
    ];

disp('input pattern');
disp(p_test);
a1 = logsig(W1 * p_test + b1);
a2 = logsig(W2 * a1 + b2);
a3 = purelin(W3 * a2 + b3);

if a3 >= 0
    disp("It is malignant");
    set(handles.answer,'string','It is possible to be a malignant tumor, you should go with a specialist');
    background1 = imread('cross.jpg');
    axes(handles.answerImg);
    imshow(background1);
    axis off;
else
    disp("It is benign");
    set(handles.answer,'String','It is possible to be a benign tumor, but you should go with a specialist');
    background1 = imread('check.jpg');
    axes(handles.answerImg);
    imshow(background1);
    axis off;
end

function radius_Callback(hObject, eventdata, handles)
% hObject    handle to radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius as text
%        str2double(get(hObject,'String')) returns contents of radius as a double


% --- Executes during object creation, after setting all properties.
function radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radius,'string','0');
set(handles.texture,'string','0');
set(handles.perimeter,'string','0');
set(handles.area,'string','0');
set(handles.smooth,'string','0');
set(handles.compact,'string','0');
set(handles.concavity,'string','0');
set(handles.concave,'string','0');
set(handles.simmetry,'string','0');
set(handles.fractal,'string','0');
set(handles.answer,'string','');
axes(handles.answerImg);
cla(handles.answerImg);

function texture_Callback(hObject, eventdata, handles)
% hObject    handle to texture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of texture as text
%        str2double(get(hObject,'String')) returns contents of texture as a double


% --- Executes during object creation, after setting all properties.
function texture_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function perimeter_Callback(hObject, eventdata, handles)
% hObject    handle to perimeter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of perimeter as text
%        str2double(get(hObject,'String')) returns contents of perimeter as a double


% --- Executes during object creation, after setting all properties.
function perimeter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to perimeter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function area_Callback(hObject, eventdata, handles)
% hObject    handle to area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of area as text
%        str2double(get(hObject,'String')) returns contents of area as a double


% --- Executes during object creation, after setting all properties.
function area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function smooth_Callback(hObject, eventdata, handles)
% hObject    handle to smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smooth as text
%        str2double(get(hObject,'String')) returns contents of smooth as a double


% --- Executes during object creation, after setting all properties.
function smooth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function compact_Callback(hObject, eventdata, handles)
% hObject    handle to compact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of compact as text
%        str2double(get(hObject,'String')) returns contents of compact as a double


% --- Executes during object creation, after setting all properties.
function compact_CreateFcn(hObject, eventdata, handles)
% hObject    handle to compact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function concavity_Callback(hObject, eventdata, handles)
% hObject    handle to concavity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of concavity as text
%        str2double(get(hObject,'String')) returns contents of concavity as a double


% --- Executes during object creation, after setting all properties.
function concavity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to concavity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function concave_Callback(hObject, eventdata, handles)
% hObject    handle to concave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of concave as text
%        str2double(get(hObject,'String')) returns contents of concave as a double


% --- Executes during object creation, after setting all properties.
function concave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to concave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function simmetry_Callback(hObject, eventdata, handles)
% hObject    handle to simmetry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of simmetry as text
%        str2double(get(hObject,'String')) returns contents of simmetry as a double


% --- Executes during object creation, after setting all properties.
function simmetry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to simmetry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fractal_Callback(hObject, eventdata, handles)
% hObject    handle to fractal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fractal as text
%        str2double(get(hObject,'String')) returns contents of fractal as a double


% --- Executes during object creation, after setting all properties.
function fractal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fractal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
