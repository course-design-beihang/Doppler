clear;
fc=1e8:1e8:1e10;
v_resolution_fc=zeros(1,100);
for i=1:100
    v_resolution_fc(i)=v_resolution(fc(i),50000,10);
end
figure(1)
plot(fc,v_resolution_fc)
title('速度分辨率与载频的关系(信号持续时间0.5s，信噪比10dB)')
xlabel('载频/Hz')
ylabel('速度分辨率/(m/s)')
N=500:500:50000;
fr=1e5;
t=N./fr;
for i=1:100
    v_resolution_fc(i)=v_resolution(1e9,N(i),10);
end
figure(2)
plot(t,v_resolution_fc)
title('速度分辨率与信号持续时间的关系(载频1GHz，信噪比10dB)')
xlabel('信号持续时间/s')
ylabel('速度分辨率/(m/s)')
SNR=0.2:0.2:20;
for i=1:100
    v_resolution_fc(i)=v_resolution(1e9,50000,SNR(i));
end
figure(3)
plot(t,v_resolution_fc)
title('速度分辨率与信噪比的关系(载频1GHz，信号持续时间0.5s)')
xlabel('信噪比/dB')
ylabel('速度分辨率/(m/s)')