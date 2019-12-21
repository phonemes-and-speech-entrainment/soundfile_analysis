function s = sharpness(sound, Fs,freqband)
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
%s=s(1:44:end);
%s=s(1:2000);
%h=0.02;
%derenv=diff(s)/h;
%posder=derenv(derenv>0);
%posder=posder/sum(s);
%sharp=mean(posder);
end



