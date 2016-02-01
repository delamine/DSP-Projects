function out_data = reverb(in_data, Fs, decay_rate, fir_delay, iir_delay)

delay1 = round(Fs*fir_delay); % FIR Delay
delay2 = round(Fs*iir_delay); % IIR Delay

%%% Filtering using FILTER command

out_data = filter([1 zeros(1,delay1) decay_rate],[1 zeros(1,delay2) -decay_rate],in_data);

%%% Nominator [1 zeros(1,delay1) decay_rate]

%%% Denominator [1 zeros(1,delay2) -decay_rate]

