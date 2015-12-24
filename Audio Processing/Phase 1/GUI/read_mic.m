%%%%% Microphone reading
function sdata = read_mic(Fs, T)

recObj = audiorecorder(Fs,16,1); % 8 bit - 1 channeş sound object
recordblocking(recObj, T);  %record T seconds
sdata = getaudiodata(recObj); %store data to micr
