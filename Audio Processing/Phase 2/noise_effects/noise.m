function out_data = noise(in_data, F, L, time)

t = linspace(0,1,L);
out_data = in_data + cos(2*pi*F*t)';