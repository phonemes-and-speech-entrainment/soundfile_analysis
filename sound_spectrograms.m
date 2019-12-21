clearvars;

addpath('/Volumes/SAMSUNG/code for experiment 1');

files = dir('*.wav');
files=files(81:end);
Soundspects=get_sound_spect(files);


a=[1:2:39,2:2:40,41:2:79,42:2:80];
Soundspects=Soundspects(a,:,:);