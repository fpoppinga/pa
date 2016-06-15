function [correlation] = correlate(x1, x2)
%CORRELATE Implementation of a cross correlation
%   this only uses built-ins, that can be easily re-coded in C++. 
    
    % zero padding to same signal length.
    if (size(x1) < size(x2)) 
        x1 = [x1 zeros(1, size(x2, 2) - size(x1, 2))];
    else
        x2 = [x2 zeros(1, size(x1, 2) - size(x2, 2))];
    end
    
    X1 = fft(x1);
    X2 = fft(fliplr(x2));
    
    correlation = ifft(X1.*X2) ./ size(X1, 2);
end

