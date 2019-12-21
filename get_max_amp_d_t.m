clear;
addpath('/Users/gigel/Documents/Speech EEG/Experiment 1/sharpness');
load('d_t_cv.mat');
cvtrans=cvtrans*1000;
files=dir('*.wav');

max_amp=zeros(1,length(files));
max_latency=zeros(1,length(files));

for i = 1:length(files)
    [sound,fs]=audioread(files(i).name);
    if size(sound,2)>1
       sound = sum(sound,2); 
    end
    tsound=[0:length(sound)-1] / fs*1000;
    range=find(tsound<=cvtrans(i));
    cutoff=max(range);
    soundenv=envelope(sound);
    [m,ind]=max(soundenv((cutoff+1):end));
    max_amp(i)=cutoff+ind-1;
    max_latency(i)=tsound(cutoff+ind-1);
end