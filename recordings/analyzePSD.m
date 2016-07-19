function [ snr ] = analyzePSD( filename )
%ANALYZESNR Summary of this function goes here
%   Detailed explanation goes here

    [y, Fs] = audioread(filename);
    l = y(:, 1);
    psd = abs(fft(l).*fliplr(fft(l)));
    plot(psd)
end

