clearvars;

%addpath('/Volumes/SAMSUNG/Sounds Experiment 1/Experimental Sounds/');
addpath('/Users/gigel/Documents/Speech EEG/Stims exp 3/Stims and properties/');
files = dir('*.wav');
%files=files(81:end);

%{
Envs=get_envelope_all(files);
%}
largest = 0;
for i=1:length(files)
    [sound,~]=audioread(files(i).name);
    if length(sound) > largest
        largest = length(sound);
    end
end

%}
Envs_broad = zeros(largest, length(files));

for i = 1:length(files)
    [sound, Fs] = audioread(files(i).name);
    new_sound = padarray(sound, (largest - length(sound)), 'post');
    env = envmin_funct(new_sound,Fs);
    Envs_broad(:,i) = env;
end

Envs_broad=Envs_broad(1:44:end,:)

%time=0:1:(size(Envs,1)-1);
%time=time/1000;

%{
fig1=figure('Renderer', 'painters', 'Position', [10 10 600 800]);
subplot(2,1,1);
plot(time,Envs(:,2),'r','LineWidth',1);
%hold on;
%plot(time,Envelopes(:,2),'b','LineWidth',1);
%xlim([0 2.5]);
%lgd=legend('Strong Edges','Weak Edges');
%lgd.FontSize = 12;
title('Syllable Envelope (''Ba'')','FontSize',15,'FontWeight','bold');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
%y=ylabel('Envelope Amplitude','Color','None','FontSize',13,'FontWeight','bold');
%set(y, 'Units', 'Normalized', 'Position', [-0.07, 0.5, 0]);
set(gca,'linewidth',1);
box off

subplot(2,1,2);
plot(time,Envs(:,56),'r','LineWidth',1);
title('Syllable Envelope (''Sa'')','FontSize',15,'FontWeight','bold');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
set(gca,'linewidth',1);
box off


fig2=figure('Renderer', 'painters', 'Position', [10 10 900 300]);
subplot(1,2,1);
plot(time,Envs(:,56),'r','LineWidth',1);
title('Narrowband Envelope ''Sa''','FontSize',15,'FontWeight','bold');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
%set(y, 'Units', 'Normalized', 'Position', [-0.07, 0.5, 0]);
set(gca,'linewidth',1);
box on

subplot(1,2,2);
plot(time,Envs_broad(:,56),'r','LineWidth',1);
title('Broadband Envelope ''Sa''','FontSize',15,'FontWeight','bold');
xlim([0 250]);
xlabel('Time (ms)','FontSize',13,'FontWeight','bold');
ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
set(gca,'linewidth',1);
box on
%}