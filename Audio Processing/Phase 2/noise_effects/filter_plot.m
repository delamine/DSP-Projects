function filter_plot(in_data, out_data, Fs, myFilter, handles)

L=length(in_data);

w = 2*pi*Fs*(0:(L-1))/L;

fft_in_data = fft(in_data, L);

axes(handles.axes3);
plot(w, fft_in_data); 
set(gca,'YDir','normal')
xlabel('Normalized Time Vector (s)')
ylabel('Normalzed Magnitude')
title('Recorded Signal')

fft_out_data = fft(out_data, L);

axes(handles.axes1);
plot(w, fft_out_data); 
set(gca,'YDir','normal')
xlabel('Normalized Time Vector (s)')
ylabel('Normalzed Magnitude')
title('Recorded Signal')
ylim([0 100]);

filtered_data = fft_out_data.*myFilter;

axes(handles.axes2);
plot(w, filtered_data); 
set(gca,'YDir','normal')
xlabel('Normalized Time Vector (s)')
ylabel('Normalzed Magnitude')
title('Recorded Signal')