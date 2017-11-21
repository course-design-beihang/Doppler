function [ Y,noise ] = noise_adder( X,SNR ) %AWGN信道加性高斯白噪声
noise = randn(size(X));
noise = noise - mean(noise);
signal_power = 1/length(X)*sum(X.^2);
noise_variance = signal_power/(10^(SNR/10));
noise = sqrt(noise_variance)/std(noise)*noise;
Y = X + noise;
end