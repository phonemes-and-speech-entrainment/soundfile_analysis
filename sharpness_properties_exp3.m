close all;clearvars;clc;
addpath('/Users/gigel/Documents/Speech EEG/Experiment 1/sharpness');
addpath('/Users/gigel/Documents/Speech EEG/Code /Entrainment_analysis/Experiment 2/okomarov-ginicoeff-0607437');
logspace=linspace(log10(80),log10(8000),33);
freqband=power(10,logspace);
files = dir('*.wav');
max_length=0;

for file=files'
    [sound,fs]=audioread(file.name);
    l=length(sound);
    if l>max_length
        max_length=l;
    end
end

env_all=zeros(length(files),max_length);
pos_der=zeros(length(files),1);
pos_der2=zeros(length(files),1);


for i=1:length(files)
    [sound,fs] = audioread(files(i).name);
    sumenv = sharpness(sound,fs,freqband);
    l_diff=size(env_all,2)-length(sumenv);
    s=padarray(sumenv,l_diff,0,'post');
    env_all(i,:)=s;
    der=diff(sumenv);
    pos_der(i)=sum(der(1:end-1)>0);
    pos_der2(i)=sum(der(1:end-1)>0)/sum(sumenv);
end


[amp,time]=max(env_all,[],2);

amp=squeeze(amp);
time=squeeze(time);

time_ms=time/fs*1000;

gini=zeros(size(env_all,1),1);
for i=1:size(gini,1)
    temp=ginicoeff(env_all(i,:));
    gini(i,:)=temp;
end

Condition={};
for i=1:length(files)
    temp=strtok(files(i).name,'.');
    Condition{end+1}=temp;
end

Condition=string(Condition)';
T=table(Condition, pos_der,pos_der2,gini);

%{



%load('d_t_cv.mat');
%load('d_t_onset.mat');
%load('max_amp_d_t.mat');

%plot(env_all(8,:));

%max_amp=max_amp/fs*1000;
%}

t=0:1:length(env_all);
t=t/44;

figure('Renderer', 'painters', 'Position', [10 10 600 800]);

subplot(3,2,1);
plot(t(1:end-1),env_all(1,:),'Color',[0.5 0.5 0.7],'LineWidth',1);
axis([0 250 0 0.7]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
title('Da Control','FontSize',14);
set(gca,'linewidth',1);

subplot(3,2,2);
plot(t(1:end-1),env_all(8,:),'Color',[0.5 0.5 0.7],'LineWidth',1);
axis([0 250 0 0.7]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
title('Ta Control','FontSize',14);
set(gca,'linewidth',1);

subplot(3,2,3);
plot(t(1:end-1),env_all(4,:),'Color',[0.5 0.5 0.7],'LineWidth',1);
axis([0 250 0 0.7]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
title('Da Click Onset','FontSize',14);
set(gca,'linewidth',1);

subplot(3,2,4);
plot(t(1:end-1),env_all(9,:),'Color',[0.5 0.5 0.7],'LineWidth',1);
axis([0 250 0 0.7]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
title('Ta Click CV','FontSize',14);
set(gca,'linewidth',1);

subplot(3,2,5);
plot(t(1:end-1),env_all(7,:),'Color',[0.5 0.5 0.7],'LineWidth',1);
axis([0 250 0 0.7]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
title('Da White Onset','FontSize',14);
set(gca,'linewidth',1);

subplot(3,2,6);
plot(t(1:end-1),env_all(12,:),'Color',[0.5 0.5 0.7],'LineWidth',1);
axis([0 250 0 0.7]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
title('Ta White CV','FontSize',14);
set(gca,'linewidth',1);