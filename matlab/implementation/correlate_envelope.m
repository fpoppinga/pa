function [correlation] = correlate_envelope(x1, x2)
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
    
    
    h = [zeros(1, ceil(size(X1, 2) / 2)) 2*ones(1, floor(size(X1, 2) / 2))];
    correlation = abs(ifft(X1.*X2.*h)) ./ size(X1, 2);
end

