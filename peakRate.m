clearvars;
cd('/Users/gigel/Documents/Speech EEG/Experiment 2/Experiment 2 stimuli');
addpath('/Users/gigel/Documents/Speech EEG/Experiment 1/sharpness');


logspace=linspace(log10(80),log10(8000),33);
freqband=power(10,logspace);
files = dir('*.wav');

env_all=zeros(length(files),5000);
peakDer=zeros(length(files),20);
for  i=1:length(files)
    [sound,Fs] = audioread(files(i).name);
    sumenv = sharpness(sound,Fs,freqband);
    sumenv=sumenv(1:44:end);
    if length(sumenv)>5000
    sumenv=sumenv(1:5000);
    end;
    if length(sumenv)<5000
    l=5000-length(sumenv);
    sumenv=padarray(sumenv,[l 0],0,'post');
    end;
    sumenv=sumenv(1:5000);
    sumenv=reshape(sumenv,250,20);
    posder=diff(sumenv);
    maxder=max(posder,[],1);
    peakDer(i,:)=maxder;
end;


meanpeakder=mean(peakDer,2);

meanpeakdercond=reshape(meanpeakder,3,15);
meanpeakdercond=mean(meanpeakdercond)';