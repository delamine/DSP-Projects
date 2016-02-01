function varargout = phs_2_430(varargin)
% PHS_2_430 MATLAB code for phs_2_430.fig
%      PHS_2_430, by itself, creates a new PHS_2_430 or raises the existing
%      singleton*.
%
%      H = PHS_2_430 returns the handle to a new PHS_2_430 or the handle to
%      the existing singleton*.
%
%      PHS_2_430('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHS_2_430.M with the given input arguments.
%
%      PHS_2_430('Property','Value',...) creates a new PHS_2_430 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before phs_2_430_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to phs_2_430_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help phs_2_430

% Last Modified by GUIDE v2.5 22-Jan-2016 17:40:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @phs_2_430_OpeningFcn, ...
                   'gui_OutputFcn',  @phs_2_430_OutputFcn, ...
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


% --- Executes just before phs_2_430 is made visible.
function phs_2_430_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to phs_2_430 (see VARARGIN)

% Choose default command line output for phs_2_430
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes phs_2_430 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

data = guidata(hObject);

data.input_control = 0;

data.dB = zeros(1,10);
data.length = 8000;
data.myFilter = createFilter(data.dB, data.length);

data.time = get(handles.record_time, 'Value')*9+1;


guidata(hObject, data);

% --- Outputs from this function are returned to the command line.
function varargout = phs_2_430_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

val = get(hObject,'Value');
dB = round((val-0.5)*40);
set(hObject,'Value',(dB/40)+0.5);

data.dB(1) = dB;
set(handles.filter1_db, 'String', num2str(data.dB(1)));
data.myFilter = createFilter(data.dB, data.length);
    
if data.input_control == 1
    filter_plot(data.in_data, data.myFilter, data.time, handles);
end

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

val = get(hObject,'Value');
dB = round((val-0.5)*40);
set(hObject,'Value',(dB/40)+0.5);

data.dB(2) = dB;
set(handles.filter2_db, 'String', num2str(data.dB(2)));
data.myFilter = createFilter(data.dB, data.length);
    
if data.input_control == 1
    filter_plot(data.in_data, data.myFilter, data.time, handles);
end

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

val = get(hObject,'Value');
dB = round((val-0.5)*40);
set(hObject,'Value',(dB/40)+0.5);

data.dB(3) = dB;
set(handles.filter3_db, 'String', num2str(data.dB(3)));
data.myFilter = createFilter(data.dB, data.length);
    
if data.input_control == 1
    filter_plot(data.in_data, data.myFilter, data.time, handles);
end

guidata(hObject, data);


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

val = get(hObject,'Value');
dB = round((val-0.5)*40);
set(hObject,'Value',(dB/40)+0.5);

data.dB(4) = dB;
set(handles.filter4_db, 'String', num2str(data.dB(4)));
data.myFilter = createFilter(data.dB, data.length);
    
if data.input_control == 1
    filter_plot(data.in_data, data.myFilter, data.time, handles);
end

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

val = get(hObject,'Value');
dB = round((val-0.5)*40);
set(hObject,'Value',(dB/40)+0.5);

data.dB(5) = dB;
set(handles.filter5_db, 'String', num2str(data.dB(5)));
data.myFilter = createFilter(data.dB, data.length);
    
if data.input_control == 1
    filter_plot(data.in_data, data.myFilter, data.time, handles);
end

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

val = get(hObject,'Value');
dB = round((val-0.5)*40);
set(hObject,'Value',(dB/40)+0.5);

data.dB(6) = dB;
set(handles.filter6_db, 'String', num2str(data.dB(6)));
data.myFilter = createFilter(data.dB, data.length);
    
if data.input_control == 1
    filter_plot(data.in_data, data.myFilter, data.time, handles);
end

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

val = get(hObject,'Value');
dB = round((val-0.5)*40);
set(hObject,'Value',(dB/40)+0.5);

data.dB(7) = dB;
set(handles.filter7_db, 'String', num2str(data.dB(7)));
data.myFilter = createFilter(data.dB, data.length);
    
if data.input_control == 1
    filter_plot(data.in_data, data.myFilter, data.time, handles);
end

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

val = get(hObject,'Value');
dB = round((val-0.5)*40);
set(hObject,'Value',(dB/40)+0.5);

data.dB(8) = dB;
set(handles.filter8_db, 'String', num2str(data.dB(8)));
data.myFilter = createFilter(data.dB, data.length);
    
if data.input_control == 1
    filter_plot(data.in_data, data.myFilter, data.time, handles);
end

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);

val = get(hObject,'Value');
dB = round((val-0.5)*40);
set(hObject,'Value',(dB/40)+0.5);

data.dB(9) = dB;
set(handles.filter9_db, 'String', num2str(data.dB(9)));
data.myFilter = createFilter(data.dB, data.length);
    
if data.input_control == 1
    filter_plot(data.in_data, data.myFilter, data.time, handles);
end

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data = guidata(hObject);


val = get(hObject,'Value');
dB = round((val-0.5)*40);
set(hObject,'Value',(dB/40)+0.5);

data.dB(10) = dB;
set(handles.filter10_db, 'String', num2str(data.dB(10)));
data.myFilter = createFilter(data.dB, data.length);
    
if data.input_control == 1
    filter_plot(data.in_data, data.myFilter, data.time, handles);
end

guidata(hObject, data);

% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function record_time_Callback(hObject, eventdata, handles)
% hObject    handle to record_time (see GCBO)
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
function record_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to record_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in load_mp3.
function load_mp3_Callback(hObject, eventdata, handles)
% hObject    handle to load_mp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = guidata(hObject);

file_name = uigetfile('*mp3','Load');

[in_data Fs] = audioread(file_name);
data.in_data = in_data(:,1);
data.length = length(data.in_data);
data.myFilter = createFilter(data.dB, data.length);
data.input_control = 1;
data.time = data.length/Fs;

filter_plot(data.in_data, data.myFilter, data.time, handles);

guidata(hObject, data);

% --- Executes on button press in record.
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = guidata(hObject);
data.length = 8000;
data.time = get(handles.record_time, 'Value')*9+1;
data.in_data = read_mic(data.time);
data.input_control = 1;

data.myFilter = createFilter(data.dB, data.length);
filter_plot(data.in_data, data.myFilter, data.time, handles);

guidata(hObject, data);
