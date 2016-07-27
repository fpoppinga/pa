%% Normal Communication with noise:
% f1 = 2500, f2 = 5000, Tsym = 5, Tg = 1

errNoNoise = [0 0 0];
errNoise1 = 1 - [212/220 215/224 226/232];
errNoise2 = 1 - [191/192 200/204 193/196];

RNoNoise = [12.8 12.8 13.87];
RNoise1 = [14.13 14.33 15.07];
RNoise2 = [12.73 13.33 12.87];

%% Silent transmitter (alsamixer = 30)
% f1 = 2500, f2 = 5000, Tsym = 5, Tg = 1
sErrNoNoise = 1 - [1 1 205/208];
sErrNoise1 = 1 - [5/36 0 0];
sErrNoise2 = [1 1 1];

sRNoNoise = [12.8 13.33 13.67];
sRNoise1 = [5/15 0 0];
sRNoise2 = [0 0 0];

%% Plots
figure();
bar([errNoNoise; errNoise1; errNoise2]);
grid on;

figure();
bar([sErrNoNoise; sErrNoise1; sErrNoise2]);
