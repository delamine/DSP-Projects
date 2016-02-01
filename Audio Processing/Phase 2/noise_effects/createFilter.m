function myFilter = createFilter(F, L)

w = 32000*pi*(0:(L-1))/L; % L samples from 0 to 2pi
w0 = 2*pi*F;

for m = 1:L
    if (w(m) < w0) % If frequency is less than cutoff frequency
        Ad(m) = 1;
    else
        Ad(m) = 0;
    end
end

k = 0:L-1;
p = exp(-i*w*1000*(L-1)/L); % Phase vector
myFilter = (Ad .* p)'; % Sampled frequency responce
