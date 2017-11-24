function [v,n]=multiple_measure(x,fs,threshold)
count=0;
f=[];
fr=100000;
N=50000;
fc=1e9;
c = 3.0*10^8;
lamda =c/fc;
A=1;
D1=50;
t=0:1/fs:(length(x)-1)/fs;
fct=A*cos(2*pi*fc*t);
y1 = x.*fct;
%低通滤波
y2 = low_pass_filter(y1,fs,1/6*fs,1/3*fs,0.057501127785,0.0001,16);
%降采样
y3=zeros(1,fix(length(y2)/D1));
for i=1:fix(length(y2)/D1)
     y3(i) = y2(D1*i);
end
%再一次低通滤波
y4 = low_pass_filter(y3,fs/D1,fs/D1/6,fs/D1/3,0.057501127785,0.0001,16);
y4_f=fft(y4,length(y4));
for i=1:fix(length(y4)/2)
    if abs(y4_f(i))>threshold
        count=count+1;
        f_temp=(i-1)/length(y4)*fs/D1;
        f=[f f_temp];
    end
end
delta=2*fr/N;
f_new=merge(f,delta);
n=length(f_new);
v=f_new*lamda/2;