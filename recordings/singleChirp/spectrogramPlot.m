%% load file
cbok = audioread('signal_single_chirp.wav');


silent = audioread('silence_single_chirp.wav');
noise1 = audioread('noise_1.wav');
noise2 = audioread('noise_2.wav');
%% plot
figure();
subplot(2, 1, 1); spectrogram(cbok(:, 2),4096, 1024, 256, 44100, 'yaxis'); caxis([-100, -45]);

%% plot noises
figure();
subplot(3, 1, 1); spectrogram(silent(:, 2),4096, 1024, 256, 44100, 'yaxis'); caxis([-100, -45]);
title('No External Noise');

subplot(3, 1, 2); spectrogram(noise1(:, 2),4096, 1024, 256, 44100, 'yaxis'); caxis([-100, -45]);
title('Medium External White Gaussian Noise (Noise 1)');

subplot(3, 1, 3); spectrogram(noise2(:, 2),4096, 1024, 256, 44100, 'yaxis'); caxis([-100, -45]);
title('Loud External White Gaussian Noise (Noise 2)');

cleanfigure;
matlab2tikz('spectrogram_noise.tex', 'height', '\figureheight', 'width', '\figurewidth');
