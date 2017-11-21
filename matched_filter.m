function y = matched_filter(x,fr,fs,N) %脉冲重复频率fr，采样率fs,输入信号x
y0 = fftshift(fft(x,N));
y_f = conj(y0)*exp(-j*2*pi*fs/fr);
y = ifft(y_f,N);
plot(real(y))
