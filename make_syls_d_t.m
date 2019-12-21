close all;
clearvars;

%noise=audioread('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/noise/whitenoise_55.wav');
%noise=audioread('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/noise/pink_52.wav'); %ta_onset
%noise=audioread('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/noise/pink_64.wav'); %da_onset
%noise=audioread('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/noise/pink_66.wav'); %ta_cv
%noise=audioread('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/noise/pink_73.wav'); %da_cv
noise=audioread('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/noise/pink_73_2.wav');%ta_maxamp
%noise=audioread('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/noise/pink_75.wav'); %da_maxamp
files=dir('*.wav');


%{
load('d_t_onset.mat');
onset=onset*1000;
onset=round(onset,2);
t_start=onset;
%}
%{
load('d_t_cv.mat');
cvtrans=cvtrans*1000;
cvtrans=round(cvtrans,2);
t_start=cvtrans;
%}

load('time_of_max_amp_d_t.mat');
%max_latency=round(max_latency,2);
t_start=max_latency;
%}



dur=5;

for i=2
    [sound,fs]=audioread(files(i).name);
    tsound=[0:length(sound)-1] / fs*1000;
    tnoise=[0:length(noise)-1] / fs*1000;
    range1=find(tsound<=t_start(i));
    cutoff1=max(range1);
    range2=find(tsound<=(t_start(i)+dur));
    cutoff2=max(range2);
    sound1=sound(1:cutoff1);
    sound2=sound((cutoff1+1):cutoff2);
    sound3=sound((cutoff2+1):end);
    rangen=find(tnoise<=dur);
    cutoffn=max(rangen);
    noise2=noise(1:cutoffn);
    if length(noise2)<=length(sound2)
       sound2=sound2(1:length(noise2));
    else
       noise2=noise2(1:length(sound2));
    end
    [high_env,low_env]=envelope(sound2);
    figure;
    plot(sound2);
    hold on;
    plot(high_env);
    hold on;
    plot(low_env);
    legend('sound','high envelope','low envelope');
    title('Ta maxamp');
    noise3=zeros(size(noise2));
    for j=1:length(sound2)
        if noise2(j)<0
            noise3(j)=noise2(j)*abs(low_env(j));
        else
            noise3(j)=noise2(j)*high_env(j);
        end
    end
    soundnew=[sound1;noise3;sound3];
    token=strtok(files(i).name,'_');
    audiowrite(strcat('/Users/gigel/Documents/Speech EEG/Stims exp 3/Re%3a_Base_syllables/',token,'_pink_maxamp.wav'),soundnew,fs);
end