function myFilter = createFilter(dB, L)  %%%% LINEAR PHASE FILTER FUNCTION

w_array = [0,32,64,125,250,500,1000,2000,4000,8000,16000]; %%% Desired edge frequencies

w = 32000*pi*(0:(L-1))/L; % L samples from 0 to 2pi, w is the frequency values
Ad = ones(1,L); %%% DEFAULT COEFFICIENT ARRAY

for x = 1:10    %% for 10 different Band  
w1 = 2*pi*w_array(x);   % First Cut-off frequency of the selected band
w2 = 2*pi*w_array(x+1); % Second Cut-off frequency 
A = 10^(dB(x)/20);  %% Input is DB hence convert them first

%%%% FILTERING

    for m = 1:L
        if (w(m) <= w2) && (w(m) >= w1) % If frequency is less than cutoff frequency
            Ad(m) = A;
        end
    end

end

k = 0:L-1;
p = exp(-i*w*1000*(L-1)/L); % Multiplies Phase vector
myFilter = (Ad .* p)'; % Sampled frequency responce
