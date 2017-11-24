function []=multiple_detect(n,v_min,v_max)
[x,fs,v_real]=multiple_signal_generate(n,v_min,v_max);
v_real_sort=sort(v_real)
[v_cal,n]=multiple_measure(x,fs,1000)
plot(v_real_sort,'b')
hold on
plot(v_cal,'r')
