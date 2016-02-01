%%%
%%%
%%% EE430 PROJECT PHASE 2  /// Sabri Bolkar, Selim Börekci
%%%
%%%%%%%%%%%%%
%% REAL-TIME DFT

Fs = 80000;                     % Sampling frequency ------ CONFIGURABLE
T = 1;                          % length of an interval ------ CONFIGURABLE
N = 5;                          % Number of interval ------ CONFIGURABLE
record_time=N*T;
t = 0:1/Fs:T-1/Fs;              % time values
nfft = 2^nextpow2(Fs);          % n-point DFT
halved = ceil((nfft+1)/2);      % half poimt
f = (0:halved-1)'*Fs/nfft;      % Frequency values 

%%% PLOTS
figure
hAx(1) = subplot(211);
hLine(1) = line('XData',t, 'YData',nan(size(t)), 'Color','b', 'Parent',hAx(1));
xlabel('Time (s)'), ylabel('Amplitude')
hAx(2) = subplot(212);
hLine(2) = line('XData',f, 'YData',nan(size(f)), 'Color','b', 'Parent',hAx(2));
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
set(hAx, 'Box','on', 'XGrid','on', 'YGrid','on')

%%%%% FFT calculations

recObj = audiorecorder(Fs,8,1);  %%%%% Creating Audio Object

% N*T seconds recording 
disp('Start speaking NOW...')
for i=1:1
    recordblocking(recObj, T);     %% Time to Record (1 second record)

    sig = getaudiodata(recObj);   %%%% Transfer auido DATA to MATRIX data
    fftMag = 20*log10( abs(fft(sig,nfft)) );    %%% FFT TIME in db
    
    set(hLine(1), 'YData',sig)      %% Plot modifications
    set(hLine(2), 'YData',fftMag(1:halved))
    title(hAx(1), num2str(i,'Interval = %d'))
    drawnow           %%% UPDATE THE PLOT        
end

disp('You shall STOP now.')
record_time                     % displays the recorded time

%%





