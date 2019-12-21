clearvars;

addpath('/Volumes/SAMSUNG/code for experiment 1');

files = dir('*.wav');
files=files(81:end);

Envelopes=get_envelope_all(files);


time=0:1:(size(Envelopes,1)-1);
time=time/1000;

fig=figure('Renderer', 'painters', 'Position', [10 10 600 400]);
plot(time,Envelopes(:,1),'r','LineWidth',1);
hold on;
plot(time,Envelopes(:,2),'b','LineWidth',1);
xlim([0 2.5]);
lgd=legend('Strong Edges','Weak Edges');
lgd.FontSize = 12;
title('Sentence Envelopes','FontSize',15,'FontWeight','bold');
xlabel('Time (seconds)','FontSize',13,'FontWeight','bold');
y=ylabel('Envelope Amplitude','FontSize',13,'FontWeight','bold');
set(y, 'Units', 'Normalized', 'Position', [-0.07, 0.5, 0]);
set(gca,'linewidth',1);
%}

strong_env=Envelopes(1:2:79);
weak_env=Envelopes(2:2:80);

strong=sum(strong_env,1);

weak=sum(weak_env,1);

[h,p]=ttest(strong,weak)