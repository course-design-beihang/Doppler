function [y,fs,v]=multiple_signal_generate(n,v_min,v_max)
fc=1e9;
fr=100000;
A=1;
rate=0.2;
N=50000;
SNR=10;
c=3e8;
f_L=(1+2*v_min/c)*fc-fr/rate;
f_H=(1+2*v_max/c)*fc+fr/rate;
B=f_H-f_L;
M=fix(f_L/B);
fs=4*fc/(2*M+1);
v=v_min+(v_max-v_min)*rand(1,n);
t=0:1/fs:fix(fs/fr)*N/fs;
y=zeros(1,length(t));
for i=1:n
    fct=A*sin(2*pi*(1+2*v(i)/c)*fc*t);
    p=zeros(1,length(t));
    count = fix(fs/fr);
    count_1 = fix(rate*fs/fr);
    for j=0:N-1
        for k=1:count_1
            p(k+j*count)=1;
        end
    end
    x=fct.*p;
    y=y+x;
end
y=noise_adder(y,SNR);