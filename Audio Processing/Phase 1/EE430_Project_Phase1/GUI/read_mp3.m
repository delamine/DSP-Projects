%%%%% Microphone reading
function [sdata, Fs] = read_mp3(name)

[sdata, Fs]= audioread(name); % Get the data


