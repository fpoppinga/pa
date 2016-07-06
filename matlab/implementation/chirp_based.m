%% Preparations
% clean up
clear all;
close all;

% set up constants
fs = 44100; %Hz
f1 = 1e3; %Hz
f2 = 3e3; %Hz
T = 221/44100; %s

% set up symbols
shape = raised_cosine(T, fs, 0.01);

figure();
plot(shape);

x1 = chirp(f1, f2, fs, T);
[x2, t] = chirp(f2, f1, fs, T);

x1_shaped = x1 .* shape;
x2_shaped = x2 .* shape; 
size_symbol = size(x1, 2);

% set up preamble, this is an up chirp with five times the 
% duration of the symbol.
preamble = chirp(f1, f2, fs, 5 * T);
preamble_shaped = raised_cosine(5 * T, fs, 0.1).*preamble;

% prepare guard interval
T_guard = 0.002;
guard = [];%zeros(1, ceil(T_guard * fs)); 
size_guard = size(guard, 2);

% plot symbols
figure(); 
set(gcf,'numbertitle','off','name','Chirp Symbols in Time Domain');
subplot(2, 1, 1); plot(t, x1);
xlabel('t in s'), ylabel('x1(t)');
subplot(2, 1, 2); plot(t, x2);
xlabel('t in s'), ylabel('x2(t)');

%% Construct a package
% A package has a constant number of bits. Each bit is mapped onto a symbol
% and guarded with a guard interval. At the beginning of each package, the
% preamble is included once.

bitsPerPackage = 16;
bits = [1 0 0 0 1 1 1 0 0 1 0 1 1 1 1 1];

signal = [preamble];
signal_shaped = [preamble_shaped];
for b = bits 
    if b == 1 
    	signal = [signal guard x1];
        signal_shaped = [signal_shaped guard x1_shaped];
    else
        signal = [signal guard x2];
        signal_shaped = [signal_shaped guard x2_shaped];
    end
end

figure();
set(gcf,'numbertitle','off','name','Time Domain Representation of a Package');
hold on;
plot(signal);
plot(signal_shaped);
hold off;
xlabel('frame index k'), ylabel('signal(k)');

% transmit multiple packages
tx = [signal guard signal guard signal guard signal];
tx_shaped = [signal_shaped guard signal_shaped guard signal_shaped guard signal_shaped];

% with noise
tx = awgn(tx, -2);

%% Spectrum of signal

figure();
hold on;
plot_spectrum(tx, fs);
% plot_spectrum(tx_shaped, fs);
%% Receiver

% listen for an time interval, long enough to record two full preambles.
size_signal = size([signal guard], 2);
record_duration = 2 * size_signal;
% recording will start with a random offset
offset = ceil(rand() * size_signal);

% two buffers will be needed, to identify subsequent packages
buffer1 = tx(1, offset:(offset + record_duration));
% the second buffer is set one signal size after the first. In live
% transmission both buffers will be exchanged after recording one
% record_duration. 
buffer2 = tx(1, (offset + size_signal):(offset + size_signal + record_duration)); 

figure();
set(gcf,'numbertitle','off','name','Recorded Buffers at Receiver');
subplot(2, 1, 1); plot(buffer1);
xlabel('frame index k'), ylabel('buffer1(k)');
subplot(2, 1, 2); plot(buffer2);
xlabel('frame index k'), ylabel('buffer2(k)');

%% Synchronization
% find packages by correlation with the preamble.
corr_preamble1 = correlate(buffer1, preamble);
corr_preamble2 = correlate(buffer2, preamble);

corr_preamble1_env = correlate_envelope(buffer1, preamble);
corr_preamble2_env = correlate_envelope(buffer2, preamble);

thresh = 0.8;
peaks1 = findAbsolutePeaks(corr_preamble1, 0.8);
peaks2 = findAbsolutePeaks(corr_preamble2, 0.8);

figure();
set(gcf,'numbertitle','off','name','Correlation of Preamble with Buffers');
subplot(2, 1, 1); 
hold all;
plot(corr_preamble1);
plot(corr_preamble1_env, '-r');
plot(peaks1, corr_preamble1_env(peaks1), 'xr');
pbaspect([5 1 1]);

pbaspect([5 1 1]);
title('Odd Buffer');
xlabel('frame index k'), ylabel('corr_{preamble1}(k)');
hold off;
subplot(2, 1, 2);
hold all;
plot(corr_preamble2);
plot(corr_preamble2_env, '-r');
plot(peaks2, corr_preamble2_env(peaks2), 'xr');
pbaspect([5 1 1]);
hold off
title('Even Buffer');
xlabel('frame index k'), ylabel('corr_{preamble2}(k)');
hold off;

%% Slice buffers at peaks of correlation
% It is assumed, that there will exist only two significant peaks. The
% buffer needs to be dropped, when more peaks have been detected. This will
% be the case, when the SNR is poor, i.e. either the noise level is too
% high or no actual transmission took place. 

% plot sliced signal
buffer1 = buffer1(1, (peaks1(1) + size(preamble, 2)):peaks1(2));
buffer2 = buffer2(1, (peaks2(1) + size(preamble, 2)):peaks2(2));
figure();
subplot(2, 1, 1); plot(buffer1);
xlabel('frame index k'), ylabel('sliced buffer1(k)');
subplot(2, 1, 2); plot(buffer2);
xlabel('frame index k'), ylabel('sliced buffer2(k)');

%% detect symbols in sliced buffers.
i = 1;
step = size_symbol + size_guard;
bits_rx = [];

corr_symbol_x1 = [];
corr_symbol_x2 = [];

detected = [];
while i <= (size(buffer1, 2) - step) 
    window = buffer1(i:(i + step));
    
    corr_x1 = correlate(window, x1);
    corr_x2 = correlate(window, x2);
    
    corr_symbol_x1 = [corr_symbol_x1 corr_x1];
    corr_symbol_x2 = [corr_symbol_x2 corr_x2];
    
    if max(abs(corr_x1)) > max(abs(corr_x2))
       bits_rx = [bits_rx 1]; 
       detected = [detected 0.3*ones(1, size(corr_x1, 2))];
    else
       bits_rx = [bits_rx 0]; 
       detected = [detected -0.3*ones(1, size(corr_x1, 2))];
    end
    
    i = i + step;
end

figure();
subplot(2, 1, 1); 
    hold on;
    plot(corr_symbol_x1); 
    plot(detected);
    hold off;
xlabel('frame index k'), ylabel('symbol correlation(k)');
title('Correlation with Up-Chirp');
pbaspect([5 1 1]);
subplot(2, 1, 2); 
    hold on;
    plot(corr_symbol_x2); 
    plot(detected);
    hold off;
title('Correlation with Down-Chirp');
xlabel('frame index k'), ylabel('symbol correlation(k)');
pbaspect([5 1 1]);
hold off;

%% Compare results
bits_rx
bits