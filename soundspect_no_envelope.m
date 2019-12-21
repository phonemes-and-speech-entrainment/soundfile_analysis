function Y=soundspect_no_envelope(files)

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
    X(:,i) = new_sound;
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