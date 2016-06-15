function [ X ] = plot_spectrum(x, fs)
%PLOT_SPECTRUM Plots the magnitude frequency response of a signal
    L = length(x);
    X = abs(fft(x)/L);
    X = X(1:L/2+1); % Spectrum up to pi
    X(2:end-1) = 2*X(2:end-1); % Correct to single-sided spectrum
    f1 = fs*(0:L/2)/L;

    % Plot frequency domain chirps
    plot(f1/1000, 10*log10(X));
    xlim([0, fs/2/1e3]);
end

