function [ x, t ] = chirp(f1, f2, fs, T)
%CHIRP Gets a chirp signal from f1 to f2 with sampling rate fs and duration T.
%   
    B = f2 - f1;
    mu = 2*pi*B/T;
    
    t = 0:1/fs:T-1/fs;
    x = cos(2*pi*f1*t+mu*t.^2/2);
end

