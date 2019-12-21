%computes sharpness as the positive derivative of the summed narrowband envelope
%this also computes normalised sharpness as the positive derivative divided by the summed value of the envelope

function s = sharpness(sound, Fs,freqband)
%get envelope
freqrad=freqband*2/Fs;
x=[];
for i=1:(length(freqrad)-2)
[b,a]=butter(2,[freqrad(i) freqrad(i+1)]);
y=filter(b,a,sound);
x=[x,y];
end;
env=envelope(x);
sumenv=sum(env,2);
s=smooth(sumenv,0.002);
%truncate envelope
s=s(1:44:end);
s=s(1:2000);
%differentiate to obtain the positive derivative
h=0.02;          %time step
derenv=diff(s)/h;
posder=derenv(derenv>0);
%normalise
posder=posder/sum(s);
sharp=mean(posder);
end



