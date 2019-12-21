close all;clearvars;clc;
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

%envf=44100;

env_all=zeros(length(files),max_length);
pos_der=zeros(length(files),1);
pos_der2=zeros(length(files),1);
peakDer=zeros(length(files),1);
time_of_peakder=zeros(length(files),1);

names={};

for i=1:length(files)
    [sound,fs] = audioread(files(i).name);
    if size(sound,2)>1
        sound=sound(:,1)+sound(:,2);
    end
    names{i}=files(i).name;
    sumenv = envmin_funct(sound,fs);
    l_diff=size(env_all,2)-length(sumenv);
    s=padarray(sumenv,l_diff,0,'post');
    env_all(i,:)=s;
    der=diff(sumenv);
    pos_der(i)=sum(der(1:end-1)>0);
    pos_der2(i)=sum(der(1:end-1)>0)/sum(sumenv);
    [maxder,ind]=max(der(1:end-3));
    peakDer(i)=maxder;
    time_of_peakder(i)=ind;
end

realtime=time_of_peakder/fs*1000;

%[amp,time]=max(env_all,[],2);

%amp=squeeze(amp);
%time=squeeze(time);

%time_ms=time/fs*1000;

Condition={};
for i=1:length(files)
    temp=strtok(files(i).name,'.');
    Condition{end+1}=temp;
end

Condition=string(Condition)';
T=table(Condition, pos_der,pos_der2,peakDer);
T2=table(Condition,realtime);



vowels_time=realtime([1,12,13,44,45]);
b_time=realtime(2:6);
d_time=realtime(7:11);
g_time=realtime(19:23);
k_time=realtime(24:28);
p_time=realtime(46:50);
t_time=realtime(61:65);
m_time=realtime(34:38);
n_time=realtime(39:43);
s_time=realtime(56:60);
z_time=realtime(71:75);
l_time=realtime(29:33);
r_time=realtime(51:55);
f_time=realtime(14:18);
v_time=realtime(66:70);
vowels_time=mean(vowels_time);
b_time=mean(b_time);
d_time=mean(d_time);
g_time=mean(g_time);
k_time=mean(k_time);
p_time=mean(p_time);
t_time=mean(t_time);
m_time=mean(m_time);
n_time=mean(n_time);
s_time=mean(s_time);
z_time=mean(z_time);
l_time=mean(l_time);
r_time=mean(r_time);
f_time=mean(f_time);
v_time=mean(v_time);
cv_all=[vowels_time;b_time;d_time;g_time;k_time;p_time;t_time;m_time;n_time;s_time;z_time;l_time;r_time;f_time;v_time];

vowels_pd=peakDer([1,12,13,44,45]);
b_pd=peakDer(2:6);
d_pd=peakDer(7:11);
g_pd=peakDer(19:23);
k_pd=peakDer(24:28);
p_pd=peakDer(46:50);
t_pd=peakDer(61:65);
m_pd=peakDer(34:38);
n_pd=peakDer(39:43);
s_pd=peakDer(56:60);
z_pd=peakDer(71:75);
l_pd=peakDer(29:33);
r_pd=peakDer(51:55);
f_pd=peakDer(14:18);
v_pd=peakDer(66:70);
vowels_pd=mean(vowels_pd);
b_pd=mean(b_pd);
d_pd=mean(d_pd);
g_pd=mean(g_pd);
k_pd=mean(k_pd);
p_pd=mean(p_pd);
t_pd=mean(t_pd);
m_pd=mean(m_pd);
n_pd=mean(n_pd);
s_pd=mean(s_pd);
z_pd=mean(z_pd);
l_pd=mean(l_pd);
r_pd=mean(r_pd);
f_pd=mean(f_pd);
v_pd=mean(v_pd);
peakder_all=[vowels_pd;b_pd;d_pd;g_pd;k_pd;p_pd;t_pd;m_pd;n_pd;s_pd;z_pd;l_pd;r_pd;f_pd;v_pd];
%}

