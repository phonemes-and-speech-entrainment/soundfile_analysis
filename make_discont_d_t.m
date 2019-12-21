clear;
clc;


files=dir('*.wav');

onset=[4.064,2.222];
cv=[8.317,43.017];
maxamp=[27.010,102.305];


for i=1:length(files)
    [sound,fs]=audioread(files(i).name);
    sound1=sound;
    sound2=sound;
    sound3=sound;
    tsound=[0:length(sound)-1] / fs*1000;
    range1=find(tsound<=onset(i));
    range2=find(tsound<=cv(i));
    range3=find(tsound<=maxamp(i));
    disc1=max(range1);
    disc2=max(range2);
    disc3=max(range3);
    sound1(disc1)=sound1(disc1)+0.6;
    sound2(disc2)=sound2(disc2)+0.6;
    sound3(disc3)=sound3(disc3)+0.6;
    token=strtok(files(i).name,'_');
    audiowrite(strcat('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/',token,'_disc_onset.wav'),sound1,fs);
    audiowrite(strcat('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/',token,'_disc_cv.wav'),sound2,fs);
    audiowrite(strcat('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/',token,'_disc_maxamp.wav'),sound3,fs);
end