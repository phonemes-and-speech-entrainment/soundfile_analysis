function X=get_envelope_all(files)
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
