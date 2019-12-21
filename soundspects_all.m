clearvars;


files = dir('*.wav');
files=files(81:end);

Soundspects=soundspect_no_envelope(files);

a=[1:2:39,2:2:40,41:2:79,42:2:80];
Soundspects=Soundspects(a,:,:);