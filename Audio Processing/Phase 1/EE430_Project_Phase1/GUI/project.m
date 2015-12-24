function varargout = project(varargin)
% PROJECT MATLAB code for project.fig
%      PROJECT, by itself, creates a new PROJECT or raises the existing
%      singleton*.
%
%      H = PROJECT returns the handle to a new PROJECT or the handle to
%      the existing singleton*.
%
%      PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT.M with the given input arguments.
%
%      PROJECT('Property','Value',...) creates a new PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help project

% Last Modified by GUIDE v2.5 10-Dec-2015 09:35:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @project_OpeningFcn, ...
                   'gui_OutputFcn',  @project_OutputFcn, ...
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


% --- Executes just before project is made visible.
function project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to project (see VARARGIN)

% Choose default command line output for project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes project wait for user response (see UIRESUME)
% uiwait(handles.figure1);

Fs = 80000; % default Fs
wind_length = 1024; % default window length                                       
ndft = 4096; % default fft points


set(handles.fs_text, 'String', num2str(Fs));
set(handles.fs_slider, 'Value', Fs/100000);
set(handles.wind_length, 'String', num2str(wind_length));
set(handles.ndft, 'String', num2str(ndft));
set(handles.win1, 'Value', 1);


axes(handles.axes10);
handles.axes10=plot(0,0);
axes(handles.axes2);
handles.axes2=plot(0,0);
axes(handles.axes3);
handles.axes3=plot(0,0);

data = guidata(hObject);
data.control = 0;
guidata(hObject, data);

% --- Outputs from this function are returned to the command line.
function varargout = project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function fs_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function wind_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wind_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function ndft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ndft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
% CALLBACK FUNCTIONS


% --- Executes on button press in mic.
function mic_Callback(hObject, eventdata, handles)
% hObject    handle to mic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Fs = str2num(get(handles.fs_text, 'String'));

data = guidata(hObject);
data.sdata = read_mic(Fs, 5);
data.control = 1;
guidata(hObject, data);

draw_spactrogram(data.sdata, handles);


% --- Executes on button press in playmic.
function playmic_Callback(hObject, eventdata, handles)
% hObject    handle to playmic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Fs = str2num(get(handles.fs_text, 'String'));
data = guidata(hObject);
sound(data.sdata, Fs) %Play the sound 


% --- Executes on button press in play_mp3.
function play_mp3_Callback(hObject, eventdata, handles)
% hObject    handle to play_mp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[sdata Fs] = read_mp3('Applause.mp3');
Fs = str2num(get(handles.fs_text, 'String'));
sound(sdata, Fs); %% PLay the sound

% --- Executes on slider movement.
function fs_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fs_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

Fs = get(hObject,'Value')*100000;
if(Fs < 1000)
    Fs = 1000;
    set(hObject, 'Value', Fs/100000);
end
set(handles.fs_text, 'String', num2str(Fs));

data = guidata(hObject);

if(data.control == 1)
    draw_spactrogram(data.sdata, handles);
end


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound;


function wind_length_Callback(hObject, eventdata, handles)
% hObject    handle to wind_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wind_length as text
%        str2double(get(hObject,'String')) returns contents of wind_length as a double

data = guidata(hObject);

if(data.control == 1)
    draw_spactrogram(data.sdata, handles);
end

function ndft_Callback(hObject, eventdata, handles)
% hObject    handle to ndft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ndft as text
%        str2double(get(hObject,'String')) returns contents of ndft as a double

data = guidata(hObject);

if(data.control == 1)
    draw_spactrogram(data.sdata, handles);
end


% --- Executes when selected object is changed in win_buttongroup.
function win_buttongroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in win_buttongroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = guidata(hObject);

if(data.control == 1)
    draw_spactrogram(data.sdata, handles);
end
