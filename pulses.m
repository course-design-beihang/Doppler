function [x,fs] = pulses( fc,fr,A,rate,N,SNR)                                    %载频fc，脉冲重复频率fr，幅度A，脉冲宽度T,采样率fs,脉冲个数N
%UNTITLED4 此处显示有关此函数的摘要
%此处显示详细说明
B=2*fr/rate;
f_L=fc-B/2;
M=fix(f_L/B);
fs=4*fc/(2*M+1);
t=0:1/fs:fix(fs/fr)*N/fs;
fct=A*sin(2*pi*fc*t);
p=zeros(1,length(t));
count = fix(fs/fr);
count_1 = fix(rate*fs/fr);
for i=0:N-1
    for j=1:count_1
        p(j+i*count)=1;
    end
end
x=fct.*p; 
x=noise_adder(x,SNR);
end