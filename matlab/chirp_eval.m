% Chirp evaluations
% Lars Urbansky, 15.04.2016
clear all;
close all;

fs = 48e3; % 48kHz sampling freq
T = 0.005; % 5ms chirp
f1 = 1e3; % Lower freq symbol 1
f2 = 3e3; % Upper freq symbol 1
phi = 0; % initial phase
B = f2-f1; % Bandwidth 
mu = 2*pi*B/T;

% Prepare chirps
t = 0:1/fs:T-1/fs;
x1 = cos(2*pi*f1*t+mu*t.^2/2+phi); % Up-chirp symbol 1
x2 = cos(2*pi*f2*t-mu*t.^2/2+phi); % Down-chirp symbol 1

% % Plot time domain chirps
% figure(1);
% set(gcf,'numbertitle','off','name','Chirp symbols');
% subplot(2,1,1); plot(t,x1);
% xlabel('t in s'), ylabel('x1(t)');
% subplot(2,1,2); plot(t,x2);
% xlabel('t in s'), ylabel('x2(t)');

% FFT
% L1 = length(x1);
% X1 = abs(fft(x1)/L1);
% X1 = X1(1:L1/2+1); % Spectrum up to pi
% X1(2:end-1) = 2*X1(2:end-1); % Correct to single-sided spectrum
% f1 = fs*(0:L1/2)/L1;
% 
% L2 = length(x2);
% X2 = abs(fft(x2)/L2);
% X2 = X2(1:L2/2+1); % Spectrum up to pi
% X2(2:end-1) = 2*X2(2:end-1); % Correct to single-sided spectrum
% f2 = fs*(0:L2/2)/L2;

% % Plot frequency domain chirps
% figure(2);
% set(gcf,'numbertitle','off','name','Freq. domain of chirp symbols');
% subplot(2,1,1); plot(f1/1000, 10*log10(X1));
% xlabel('f in kHz'), ylabel('|X_1(f)| in dB');
% xlim([0, fs/2/1e3]);
% subplot(2,1,2); plot(f2/1000, 10*log10(X2));
% xlabel('f in kHz'), ylabel('|X_2(f)| in dB');
% xlim([0, fs/2/1e3]);

% Generate reversed chirps
x1_rev = x2;
x2_rev = x1;

% Generate symbol sequence which will be sent
tx = [x1, x2, x1, x2, x1, x2];

% Assume tx has been sent
c1 = conv(tx, x1_rev);
c2 = conv(tx, x2_rev);
t_rec = 0:1/fs:7*T-2/fs;
% 
% % Plot the transmit signal
% figure(3);
% set(gcf,'numbertitle','off','name','Transmitted signal');
% plot(0:1/fs:6*T-1/fs, tx);

%envelope transform (using hilbert transform to calculate the analytical
%signal)
c1f = fft(c1);
c2f = fft(c2);
h = [zeros(1, floor(length(c1)/2)), 2 * ones(1, ceil(length(c1)/2))];
env1 = abs(ifft(h.*c1f));
env2 = abs(ifft(h.*c2f));

% Plot correlations1
figure(4);
set(gcf,'numbertitle','off','name','Matched filtering');
subplot(2,1,1); hold on; plot(t_rec, c1); plot(t_rec, env1, 'r'); hold off; 
subplot(2,1,2); hold on; plot(t_rec, c2); plot(t_rec, env2, 'r'); hold off;