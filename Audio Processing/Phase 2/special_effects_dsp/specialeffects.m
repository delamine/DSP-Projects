function varargout = specialeffects(varargin)
% SPECIALEFFECTS MATLAB code for specialeffects.fig
%      SPECIALEFFECTS, by itself, creates a new SPECIALEFFECTS or raises the existing
%      singleton*.
%
%      H = SPECIALEFFECTS returns the handle to a new SPECIALEFFECTS or the handle to
%      the existing singleton*.
%
%      SPECIALEFFECTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPECIALEFFECTS.M with the given input arguments.
%
%      SPECIALEFFECTS('Property','Value',...) creates a new SPECIALEFFECTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before specialeffects_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to specialeffects_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help specialeffects

% Last Modified by GUIDE v2.5 23-Jan-2016 16:50:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @specialeffects_OpeningFcn, ...
                   'gui_OutputFcn',  @specialeffects_OutputFcn, ...
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


% --- Executes just before specialeffects is made visible.
function specialeffects_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to specialeffects (see VARARGIN)

% Choose default command line output for specialeffects
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes specialeffects wait for user response (see UIRESUME)
% uiwait(handles.figure1);  

data = guidata(hObject);

set(handles.play,'Enable','off');
set(handles.stop,'Enable','off');

data.time = 1;
data.speed = 1;
data.reverb_check = 0;
data.decay_rate = 0;
data.fir_delay = 0.008;
data.iir_delay = 0.025;
data.stereo_delay = 0;
data.stereo_check = 0;

set(handles.time,'Value',(data.time-1)/9);
set(handles.speed, 'Value', 0.7);
set(handles.reverb_check, 'Value', data.reverb_check);
set(handles.decay_rate, 'Value', data.decay_rate);
set(handles.fir_delay, 'Value', data.fir_delay);
set(handles.iir_delay, 'Value', data.iir_delay);
set(handles.stereo_check, 'Value', data.stereo_check);
set(handles.stereo_delay, 'Value', data.stereo_delay);

set(handles.time_text, 'String', num2str(data.time));
set(handles.iir_delay_text, 'String', num2str(0.7));
set(handles.decay_rate_text, 'String', num2str(data.decay_rate));
set(handles.fir_delay_text, 'String', num2str(data.fir_delay));
set(handles.iir_delay_text, 'String', num2str(data.iir_delay));
set(handles.stereo_delay_text, 'String', num2str(data.stereo_delay));

guidata(hObject, data);

% --- Outputs from this function are returned to the command line.
function varargout = specialeffects_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.play,'Enable','off');
set(handles.stop,'Enable','off');

data = guidata(hObject);

file_name = uigetfile('*mp3','Load');

if file_name ~= 0
    [data.in_data data.Fs] = audioread(file_name);
    guidata(hObject, data);
    set(handles.play,'Enable','on');
    set(handles.stop,'Enable','on');
end

% --- Executes on button press in record.
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.play,'Enable','off');
set(handles.stop,'Enable','off');

data = guidata(hObject);
data.length = 8000;
data.Fs = data.length / data.time;

recObj = audiorecorder(data.Fs,16,1); % 16 bit - 1 channeş sound object
recordblocking(recObj, data.time);  %record T seconds
data.in_data = getaudiodata(recObj); %store data to micr

guidata(hObject, data);
set(handles.play,'Enable','on');
set(handles.stop,'Enable','on');

% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.stop,'Enable','off');
data = guidata(hObject);

%%% CHANGIND THE SOUND SPEED
Fs = data.Fs*data.speed;    %% Calculate the new Fs
data.out_data = data.in_data;   

%%% REVERBERATION
if data.reverb_check == 1
    data.out_data = reverb(data.out_data, Fs, data.decay_rate, data.fir_delay, data.iir_delay);
end

%%% STEREO EFFECT
if data.stereo_check == 1
    data.out_data = synthetic_stereo(data.out_data, Fs, data.stereo_delay);
end
soundsc(data.out_data, Fs);
set(handles.stop,'Enable','on');

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound;

% --- Executes on slider movement.
function decay_rate_Callback(hObject, eventdata, handles)
% hObject    handle to decay_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

data.decay_rate = round(get(hObject,'Value'), 3);
set(hObject,'Value',data.decay_rate);
set(handles.decay_rate_text, 'String', num2str(data.decay_rate));

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function decay_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to decay_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fir_delay_Callback(hObject, eventdata, handles)
% hObject    handle to fir_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

data.fir_delay = round(get(hObject,'Value'), 3);
set(hObject,'Value',data.fir_delay);
set(handles.fir_delay_text, 'String', num2str(data.fir_delay));

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function fir_delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fir_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function iir_delay_Callback(hObject, eventdata, handles)
% hObject    handle to iir_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

data.iir_delay = round(get(hObject,'Value'), 3);
set(hObject,'Value',data.iir_delay);
set(handles.iir_delay_text, 'String', num2str(data.iir_delay));

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function iir_delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iir_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function speed_Callback(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

speed = round(get(hObject,'Value'), 1);
set(hObject,'Value', speed);

speed = (speed-0.7)*10;

if speed >= 0
    data.speed = speed + 1;
else
    data.speed = 1 / abs(speed-1);
end

set(handles.speed_text, 'String', rats(data.speed));

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function time_Callback(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);
val = get(hObject,'Value');
data.time = round(val*9+1);
set(hObject,'Value',(data.time-1)/9);

set(handles.time_text, 'String', num2str(data.time));


guidata(hObject, data);


% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function stereo_delay_Callback(hObject, eventdata, handles)
% hObject    handle to stereo_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

data.stereo_delay = round(get(hObject,'Value'), 3);
set(hObject,'Value',data.stereo_delay);
set(handles.stereo_delay_text, 'String', num2str(data.stereo_delay));

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function stereo_delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stereo_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in stereo_check.
function stereo_check_Callback(hObject, eventdata, handles)
% hObject    handle to stereo_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stereo_check

data = guidata(hObject);
data.stereo_check = get(hObject, 'Value');
guidata(hObject, data);

% --- Executes on button press in reverb_check.
function reverb_check_Callback(hObject, eventdata, handles)
% hObject    handle to reverb_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of reverb_check

data = guidata(hObject);
data.reverb_check = get(hObject, 'Value');
guidata(hObject, data);
