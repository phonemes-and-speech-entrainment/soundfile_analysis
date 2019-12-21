clearvars;
addpath('/Users/gigel/Documents/Speech EEG/Experiment 1/sharpness');
addpath('/Users/gigel/Documents/Speech EEG/Experiment 3 (final)');

logspace=linspace(log10(80),log10(8000),33);
freqband=power(10,logspace);

files = dir('*.wav');
files=files(81:160);
norm_sharpness=zeros(1,length(files));

%{
largest = 0;
for i=1:length(files)
    [sound,~]=audioread(files(i).name);
    if length(sound) > largest
        largest = length(sound);
    end
end
%}


for i = 1:length(files)
    [sound, Fs] = audioread(files(i).name);
    %new_sound = padarray(sound, (largest - length(sound)), 'post');
    snorm = sharpness(sound,Fs,freqband);
    norm_sharpness(i)=snorm;
end

engs=norm_sharpness(1:2:39);
engw=norm_sharpness(2:2:40);
russ=norm_sharpness(41:2:79);
rusw=norm_sharpness(42:2:80);

[~,p1,~,stats1]=ttest(engs,engw)
[~,p2,~,stats2]=ttest(russ,rusw)
[~,p3,~,stats3]=ttest(engs,russ)
[~,p4,~,stats4]=ttest(engw,rusw)

meanengs=mean(engs);
meanengw=mean(engw);
meanruss=mean(russ);
meanrusw=mean(rusw);

n=length(engs);

error_engs=std(engs)./sqrt(n);
error_engw=std(engw)./sqrt(n);
error_russ=std(russ)./sqrt(n);
error_rusw=std(rusw)./sqrt(n);

error=[error_engs,error_engw;error_russ,error_rusw];
bardata=[meanengs,meanengw;meanruss,meanrusw];


fig=figure('Renderer', 'painters', 'Position', [10 10 600 400]);
b = bar(bardata,'FaceColor','flat');
b(1).FaceColor='r';
b(2).FaceColor='b';
ylim([0 0.00000027])
hold on;
x=1:2;
mysigstar(gca,[0.9 1.1], 0.00000022, p1);
mysigstar(gca,[1.9 2.1], 0.00000023, p2);
errH1 = errorbar(x-0.15,bardata(:,1),error(:,1),'.','Color','k');
errH2 = errorbar(x+0.15,bardata(:,2),error(:,1),'.','Color','k'); 
errH1.LineWidth = 1.5;
errH2.LineWidth = 1.5;
xticks([1 2])
xticklabels({'English','Russian'})
legend({'Strong','Weak'},'Location','northeast');
y=ylabel('Normalised Sharpness','FontSize',13,'FontWeight','bold');
set(y, 'Units', 'Normalized', 'Position', [-0.07, 0.5, 0]);
title('Normalised Sharpness of Stimuli in Each Condition','FontSize',15,'FontWeight','bold');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontSize',13,'FontWeight','bold');
set(gca,'linewidth',1);
hold off;


g1=repelem([{'english'}, {'russian'}], [40 40])';
g2=repmat({'strong','weak'},1,40)';
p = anovan(norm_sharpness,{g1,g2},'model','interaction','varnames',{'Language','Sharpness'})

