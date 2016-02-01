function out_data = synthetic_stereo(in_data, Fs, stereo_delay)

delay = round(Fs*stereo_delay); %% Delay is the multiplative value*Fs

delayed_data = filter([zeros(1,delay) 1],[1],in_data); %% Using FILTER command
%%% Note that it's an FIR filter hence denominator is unity

out_data = [in_data delayed_data]; %%% Two channel data is created for the AudioObject