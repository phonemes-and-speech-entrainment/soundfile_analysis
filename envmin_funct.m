function [downsenv] = envmin_funct(sound, soundf)
% function [downsenv] = envmin_funct(sound, soundf,envf)
% inputs: 
%   - sound: sound waveform, 1xsamples
%   - soundf: sound sampling frequency
%   - envf: target sampling frequency of envelope
% output: 
%   - broadband sound envelope, low-pass filtered at 10 Hz and downsampled to envf.

% (c) Yulia Oganian, May 2019. yulia.oganian@ucsf.edu

rectsound  = abs(sound);
[b,a] = butter(2, 10/(soundf/2));
cenv = filtfilt(b, a, rectsound);
%downsenv = resample(cenv, (1:length(cenv))/soundf, envf);
downsenv=cenv;
downsenv(downsenv<0) =0;

%edit Oana Cucu: no downsampling needed for my experiments

