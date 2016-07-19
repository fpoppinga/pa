%% Preparations
% clean up
clear all;
close all;

% set up constants
fs = 44100; %Hz
f1 = 1000; %Hz
f2 = 3000; %Hz
T = 0.005; %s

% set up symbocls
x1 = chirp(f1, f2, fs, T);
[x2, t] = chirp(f2, f1, fs, T);
size_symbol = size(x1, 2);

% set up preamble, this is an up chirp with five times the 
% duration of the symbol.
preamble = chirp(f1, f2, fs, 5 * T);

% prepare guard interval
T_guard = 0.002;
guard = zeros(1, ceil(T_guard * fs)); 
size_guard = size(guard, 2);

% plot symbols
figure(); 
set(gcf, 'numbertitle', 'off', 'name', 'Chirp Symbols in Time Domain');
subplot(2, 1, 1); plot(t, x1);
title('Up-Chirp (1kHz to 3kHz)');
xlabel('t in s'), ylabel('x_u(t)');
pbaspect([5 1 1]);

subplot(2, 1, 2); plot(t, x2);
title('Down-Chirp (3kHz to 1kHz)');
xlabel('t in s'), ylabel('x_d(t)');
pbaspect([5 1 1]);

cleanfigure;
matlab2tikz('chirps.tex', 'height', '\figureheight', 'width', '\figurewidth');

%% Correlation

signal = [zeros(1, size(x1, 2)) x1];

autoCorrelation = correlate(signal, x1);
crossCorrelation = correlate(signal, x2);

ks = 1:1:size(autoCorrelation, 2);
ks = ks - (size(autoCorrelation, 2) / 2);

% plot symbols
figure(); 
set(gcf,'numbertitle','off','name','Correlation of Chirps');
subplot(2, 1, 1); plot(ks, autoCorrelation);
axis([ks(1) ks(end) -0.3 0.3]);
title('Correlation of Up-Chirp and Up-Chirp (centered)');
xlabel('k'), ylabel('R_{x_ux_u}(k)');
pbaspect([5 1 1]);

subplot(2, 1, 2); plot(ks, crossCorrelation);
axis([ks(1) ks(end) -0.3 0.3]);
title('Correlation of Up-Chirp and Down-Chirp (centered)');
xlabel('k'), ylabel('R_{x_ux_d}(k)');
pbaspect([5 1 1]);

cleanfigure;
matlab2tikz('chirpCorrelation.tex', 'height', '\figureheight', 'width', '\figurewidth');

%% High frequency chirps
% clean up
clear all;
close all;

% set up constants
fs = 44100; %Hz
f1 = 6000; %Hz
f2 = 8000; %Hz
T = 0.005; %s

% set up symbocls
x1 = chirp(f1, f2, fs, T);

%% plot higher frequency chirps

signal = [zeros(1, size(x1, 2)) x1];

autoCorrelation = correlate(signal, x1);
peaks_bad = findAbsolutePeaks(autoCorrelation, 0.8);

ks = 1:1:size(autoCorrelation, 2);
ks = ks - (size(autoCorrelation, 2) / 2);


% plot symbols
figure(); 
hold all;
plot(ks, autoCorrelation);
plot(peaks_bad - (size(autoCorrelation, 2) / 2), autoCorrelation(peaks_bad), 'xb');
hold off;
axis([ks(1) ks(end) -0.3 0.3]);
title('Correlation of Up-Chirp and Up-Chirp (centered)');
xlabel('k'), ylabel('R_{x_ux_u}(k)');
pbaspect([5 1 1]);

cleanfigure;
matlab2tikz('chirpCorrelation_hf.tex', 'height', '\figureheight', 'width', '\figurewidth');

%% plot envelope

correlation_env = correlate_envelope(signal, x1);

thresh = 0.8;
peaks1 = findAbsolutePeaks(correlation_env, 0.8);

figure();
hold all;
plot(ks, autoCorrelation);
plot(ks, correlation_env, 'r');
plot(peaks1 - (size(autoCorrelation, 2) / 2), correlation_env(peaks1), 'xr');
hold off;

axis([ks(1) ks(end) -0.3 0.3]);
title('Correlation with Envelope Detection');
xlabel('k'), ylabel('R_{x_ux_u}(k)');
pbaspect([5 1 1]);

matlab2tikz('chirpCorrelation_hf_envelope.tex', 'height', '\figureheight', 'width', '\figurewidth');

%% correlation of multiple frequency symbols
% clean up
clear all;
close all;

% set up constants
fs = 44100; %Hz
f1 = 1000; %Hz
f2 = 3000; %Hz
f3 = 5000; %Hz
T = 0.005; %s

% set up symbocls
x1 = chirp(f1, f2, fs, T);
[x2, t] = chirp(f2 + 500, f3 + 500, fs, T);
size_symbol = size(x1, 2);

% set up preamble, this is an up chirp with five times the 
% duration of the symbol.
preamble = chirp(f1, f2, fs, 5 * T);

% prepare guard interval
T_guard = 0.002;
guard = zeros(1, ceil(T_guard * fs)); 
size_guard = size(guard, 2);


signal = [zeros(1, size(x1, 2)) x1];

autoCorrelation = correlate(signal, x1);
crossCorrelation = correlate(signal, x2);

ks = 1:1:size(autoCorrelation, 2);
ks = ks - (size(autoCorrelation, 2) / 2);

% plot symbols
figure(); 
set(gcf,'numbertitle','off','name','Correlation of Chirps');
plot(ks, crossCorrelation);
axis([ks(1) ks(end) -0.3 0.3]);
title('Correlation of Chirps of Different Frequencies');
xlabel('k'), ylabel('R_{x_lx_h}(k)');
pbaspect([5 1 1]);

cleanfigure;
matlab2tikz('chirps_multiple.tex', 'height', '\figureheight', 'width', '\figurewidth');