%{
Computes narrowband envelope using Hilbert transform

sound = input audio vector
Fs = sampling frequency 
freqband = frequency bands to filter through, necessary to obtain narrowband envelope
%}

function s = get_envelope(sound, Fs,freqband)
freqrad=freqband*2/Fs;
x=[];
%filter sound through frequency bands
for i=1:(length(freqrad)-2)
    [b,a]=butter(2,[freqrad(i) freqrad(i+1)]);
    y=filter(b,a,sound);
    x=[x,y];
end
%take envelope of sound filtered through each frequency band
env=envelope(x);
%sum of all envelopes
sumenv=sum(env,2);
%smooth envelope
s=smooth(sumenv,0.02);
end
