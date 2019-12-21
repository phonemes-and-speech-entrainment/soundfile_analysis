function s = trunc_sound(sound,Fs)
logspace=linspace(log10(80),log10(8000),33);
freqband=power(10,logspace);
x = [];
freqrad=freqband*2/Fs;
for i=1:(length(freqrad)-1)
[b,a]=butter(2,[freqrad(i) freqrad(i+1)]);
y=filter(b,a,sound);
x=[x,y];
end;
env=envelope(x);
sumenv=sum(env,2);
sumenv=smooth(sumenv,0.02);

s = sumenv(1:44:end);
if length(s)>250
    s=s(1:250);
end;
if length(s)<250
    l=250-length(s);
    s=padarray(s,[l 0],0,'post');
end;