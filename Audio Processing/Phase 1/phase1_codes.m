%%%%%%%%%% 
%
% EE 430 PROJECT Sabri Bolkar - Selim Borekci
%
%%%%%%%%%%

%% STEP 1

%%%%% Microphone reading

Fs= 80000; % A/D sampling rate in Hz ---------CONFIGURABLE
T=5; % Record Time in seconds ---------CONFIGURABLE

recObj = audiorecorder(Fs,16,1); % 8 bit - 1 channel sound object
recordblocking(recObj, T);  %record T seconds
data = getaudiodata(recObj); %store sound data to "data"

% play(recObj, Fs) %Play the sound 

%%
%%%%%%%%%%%%%%%%%%%%
% MP3 data reading 

 name= 'feel.mp3' ; %% file name to be read

 [data2, Fs]= audioread('feel.mp3'); % Get the data

% sound('feel.mp3', Fs); %% PLay the sound

%%
%%%%%%%%%%%%%%%%%%%%
% SPECTROGRAM

% Sample audio data FOR CHECKING
%[data, Fs] = audioread('Applause.mp3');   

%%%% CHANGE data with data2 for mp3 processing 
                       
data_max = max(abs(data));                 
data = data/data_max;   %% Normalization                      

% Default input parameters
data_length = length(data);                  
wind_length = 1024;    %%% ---------CONFIGURABLE                   
hop = wind_length/2;     %% hopsize; take windows as 50% overlap  ---------CONFIGURABLE                  
ndft = 4096;         %% fft points ---------CONFIGURABLE         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DFT

% window1 Hamming
win1 = hamming(wind_length, 'periodic');% ---------CONFIGURABLE

% window2 Rect
win2 = ones(wind_length,1); %---------CONFIGURABLE

% Spect will be the spectrogram
rown = ceil((1+ndft)/2);            
coln = 1+fix((data_length-wind_length)/hop);        
spect = zeros(rown, coln);          

indx = 0;
col = 1;

%%%% DFT calculation
while indx + wind_length <= data_length
    % windowing
    windowed_data = data(indx+1:indx+wind_length).*win1; %%%%% CHANGE WINDOW FUNC
    
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
% sound(data)

%%
% PLOTING %%%%%%%%%%%%%%%%%%%%%%

%plot the sound data

subplot(3,1,1)
Tx=linspace(0, T, length(data));
plot(Tx, data);
set(gca,'YDir','normal')
xlabel('Time (s)')
ylabel('Sample Magnitude')
title('Recorded Signal')

%%% plot the spectrogram

%%%% 3D
subplot(3,1,2)
h=surf(t, f, spect); colorbar;
set(h,'LineStyle','none') %% turn linestyle off to see the graph
set(gca,'YDir','normal')
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Spectrogram of the Signal')

handle = colorbar;
ylabel(handle, 'Magnitude (dB)')

%%%% 2D
subplot(3,1,3)
imagesc(t, f, spect) %%% Plot it with color info

set(gca,'YDir','normal')
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Spectrogram of the Signal')

handle = colorbar;
ylabel(handle, 'Magnitude (dB)')

%%
