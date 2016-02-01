function in_data = read_mic(T)

L = 8000;
Fs = L/T;

recObj = audiorecorder(Fs,16,1); % 16 bit - 1 channeş sound object
recordblocking(recObj, T);  %record T seconds
in_data = getaudiodata(recObj); %store data to micr
