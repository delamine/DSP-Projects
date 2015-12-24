% SPECTROGRAM
function draw_spactrogram(sdata, handles)

% Sample audio data
% [sdata, Fs] = audioread('stft/track.wav');   

%%%%
                       
data_max = max(abs(sdata));                 
sdata = sdata/data_max;   %% Normalization                      

% Sample input parameters
Fs = str2num(get(handles.fs_text, 'String'));
wind_length = str2num(get(handles.wind_length, 'String'));
ndft = str2num(get(handles.ndft, 'String'));
data_length = length(sdata);  
hop = wind_length/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DFT

% Window
win1 = get(handles.win1, 'Value');

if(win1 == 1)
   wind = hamming(wind_length, 'periodic');
else
    wind = ones(wind_length,1);
end

% Spect will be the spectrogram
rown = ceil((1+ndft)/2);            
coln = 1+fix((data_length-wind_length)/hop);        
spect = zeros(rown, coln);          

indx = 0;
col = 1;

%%%% DFT calculation
while indx + wind_length <= data_length
    % windowing
    windowed_data = sdata(indx+1:indx+wind_length).*wind;
    
    % FFT
    X = fft(windowed_data, ndft);
    
 
    spect(:, col) = X(1:rown);
    
    indx = indx + hop;
    col = col + 1;
end


t = (wind_length/2:hop:wind_length/2+(coln-1)*hop)/Fs;
f = (0:rown-1)*Fs/ndft;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spect= 20*log10(abs(spect));  %%% TAKING DB of Spectrogram data

%Play the sound
% sound(sdata)

% PLOTING %%%%%%%%%%%55
Tx=linspace(0, 1, length(sdata));
axes(handles.axes10);
handles.axes10 = plot(Tx, sdata); 
set(gca,'YDir','normal')
xlabel('Normalized Time Vector (s)')
ylabel('Normalzed Magnitude')
title('Recorded Signal')


%%%% 3D
axes(handles.axes2);
handles.axes2 = surf(t, f, spect,'linestyle', 'none'); 
colorbar;
% set(handles.axes1,'LineStyle','none') %% turn linestyle off to see the graph
set(gca,'YDir','normal')
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Spectrogram of the Signal')

handle = colorbar;
ylabel(handle, 'Magnitude (dB)')

%%%% 2D
axes(handles.axes3);
handles.axes3 = imagesc(t, f, spect); %%% Plot it with color info

set(gca,'YDir','normal')
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Spectrogram of the Signal')

handle = colorbar;
ylabel(handle, 'Magnitude (dB)')