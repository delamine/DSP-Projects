function varargout = tone_removal(varargin)
% TONE_REMOVAL MATLAB code for tone_removal.fig
%      TONE_REMOVAL, by itself, creates a new TONE_REMOVAL or raises the existing
%      singleton*.
%
%      H = TONE_REMOVAL returns the handle to a new TONE_REMOVAL or the handle to
%      the existing singleton*.
%
%      TONE_REMOVAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TONE_REMOVAL.M with the given input arguments.
%
%      TONE_REMOVAL('Property','Value',...) creates a new TONE_REMOVAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tone_removal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tone_removal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tone_removal

% Last Modified by GUIDE v2.5 25-Jan-2016 01:35:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tone_removal_OpeningFcn, ...
                   'gui_OutputFcn',  @tone_removal_OutputFcn, ...
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


% --- Executes just before tone_removal is made visible.
function tone_removal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tone_removal (see VARARGIN)

% Choose default command line output for tone_removal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tone_removal wait for user response (see UIRESUME)
% uiwait(handles.figure1);

data = guidata(hObject);

data.time = 4;
data.noise_freq = 20000;
data.length = 480000;
data.input_control = 0;
data.Fs = data.length / data.time;

set(handles.time,'Value',(data.time-1)/9);
set(handles.noise_frequency, 'Value', 0);

set(handles.time_text, 'String', num2str(data.time));
set(handles.noise_text, 'String', num2str('20'));

data.myFilter = createFilter(15000, data.length);

guidata(hObject, data);


% --- Outputs from this function are returned to the command line.
function varargout = tone_removal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in record.
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = guidata(hObject);

recObj = audiorecorder(data.Fs,16,1); % 16 bit - 1 channeş sound object
recordblocking(recObj, data.time);  %record T seconds
data.in_data = getaudiodata(recObj); %store data to micr

data.out_data = noise(data.in_data, data.noise_freq, data.length, data.time);

filter_plot(data.in_data, data.out_data, data.Fs, data.myFilter, handles);

data.input_control = 1;

guidata(hObject, data);

% --- Executes on slider movement.
function noise_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to noise_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

noise_freq = get(hObject,'Value');
set(handles.noise_frequency, 'Value', round(noise_freq, 1));
noise_freq = round(noise_freq, 1)*100+20;
set(handles.noise_text, 'String', num2str(noise_freq));
data.noise_freq = noise_freq*1000;

set(handles.noise_text, 'String', num2str(noise_freq));

if data.input_control == 1
    data.out_data = noise(data.in_data, data.noise_freq, data.length, data.time);

    filter_plot(data.in_data, data.out_data, data.Fs, data.myFilter, handles);
end
guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function noise_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise_frequency (see GCBO)
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
