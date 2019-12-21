function Y=get_sound_spect(files)
logspace=linspace(log10(80),log10(8000),33);
freqband=power(10,logspace);
for i=1:length(freqband)
    if freqband(i)<1000
        freqband(i)=roundn(freqband(i),1);
    else freqband(i)=roundn(freqband(i),2);
    end
end


largest = 0;
for i=1:length(files)
    [sound,~]=audioread(files(i).name);
    if length(sound) > largest
        largest = length(sound);
    end
end


X = zeros(largest, length(files));

for i = 1:length(files)
    [sound, Fs] = audioread(files(i).name);
    new_sound = padarray(sound, (largest - length(sound)), 'post');
    env = get_envelope(new_sound,Fs,freqband);
    X(:,i) = env;
end

X=X(1:44:end,:);
X=X(500:2000,:);

X=X';

F1 = 1:0.5:10;
F2 = 10:1:40;
F  = [F1,F2];
N  = size(X,2);
nsc = floor(N/2);
nov = 740;

Y=zeros(size(X,1),length(F),76);

for j=1:size(X,1)
        [z,~,~]=spectrogram(X(j,:),hann(nsc),nov,F,1000);
        Y(j,:,:)=z;
end



