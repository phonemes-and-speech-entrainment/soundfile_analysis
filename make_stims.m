clear;
clc;
files=dir('*.wav');

for i=1:length(files)
    [sound,fs]=audioread(files(i).name);
    stim=repmat(sound,40,1);
    token=strtok(files(i).name,'.');
     audiowrite(strcat('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/disc 0.6/',token,'_stim.wav'),stim,fs);
end