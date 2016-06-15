%% Preparations
% clean up
clear all;
close all;

% set up constants
fs = 44100; %Hz
f1 = 1000; %Hz
f2 = 3000; %Hz
T = 0.005; %s

% set up symbols
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
set(gcf,'numbertitle','off','name','Chirp Symbols in Time Domain');
subplot(2, 1, 1); plot(t, x1);
xlabel('t in s'), ylabel('x1(t)');
subplot(2, 1, 2); plot(t, x2);
xlabel('t in s'), ylabel('x2(t)');

%% Correlation

