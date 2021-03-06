%% load file
cbok = audioread('signal_single_chirp.wav');


silent = audioread('silence_single_chirp.wav');
noise1 = audioread('noise_1.wav');
noise2 = audioread('noise_2.wav');

cbokSilent = audioread('noisy_single_silent.wav');

mcok = audioread('signal_multi_chirp.wav');
mcokNoisy = audioread('noisy_multi.wav');
%% plot
figure();
spectrogram(cbok(:, 2),4096, 1024, 256, 44100, 'yaxis'); caxis([-100, -45]);
title('CBOK Transmission (no external noise)');
cleanfigure;
matlab2tikz('spectrogram_cbok.tex',  'height', '\figureheight', 'width', '\figurewidth');

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

%% very bad transmission conditions
figure(); 

subplot(2, 1, 1); spectrogram(noise1(:, 2),4096, 1024, 256, 44100, 'yaxis'); caxis([-100, -45]);
title('Medium External White Gaussian Noise (Noise 1)');

subplot(2, 1, 2); spectrogram(cbokSilent(:, 2),4096, 1024, 256, 44100, 'yaxis'); caxis([-100, -45]);
title('CBOK Transmission (reduced volume, Noise 1)');
cleanfigure;
matlab2tikz('spectrogram_am30_noise.tex', 'height', '\figureheight', 'width', '\figurewidth');

%% MCOK 
figure(); 

subplot(2,1,1); spectrogram(mcok(:, 2),4096, 1024, 256, 44100, 'yaxis'); caxis([-100, -45]);
title('MCOK Transmission (no external noise)');

subplot(2,1,2); spectrogram(mcokNoisy(:, 2),4096, 1024, 256, 44100, 'yaxis'); caxis([-100, -45]);
title('MCOK Transmission (Noise 2)');
cleanfigure;
matlab2tikz('spectrogram_mcok_noise.tex', 'height', '\figureheight', 'width', '\figurewidth');
