function [y,fs] = Doppler(v,fc,fr,A,rate,N,SNR)
c = 3.0*10^8;
lamda =c/fc;
fd= 2*v/lamda;
[y,fs]= pulses(fc+fd,fr,A,rate,N,SNR);