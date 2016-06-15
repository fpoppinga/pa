function F=fftdb(f)
% F=fftdb(f)
% calculate the 1024-point FFT in dB of the time signal f
F=20*log10(abs(fft(f,1024)));
