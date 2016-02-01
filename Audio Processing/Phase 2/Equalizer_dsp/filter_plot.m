function filter_plot(in_data, myFilter, time, handles)

L=length(in_data);

Tx=linspace(0, time, L);
axes(handles.axes1);
plot(Tx, in_data); 
set(gca,'YDir','normal')
xlabel('Normalized Time Vector (s)')
ylabel('Normalzed Magnitude')
title('Recorded Signal')


fft_data = fft(in_data, L);
out_data = fft_data.*myFilter;
spect = ifft(out_data, L);

axes(handles.axes2);
plot(Tx, spect); 
set(gca,'YDir','normal')
xlabel('Normalized Time Vector (s)')
ylabel('Normalzed Magnitude')
title('After Filtering')

axes(handles.axes3);
spectrogram(spect, 8000);
title('spectrogram')
