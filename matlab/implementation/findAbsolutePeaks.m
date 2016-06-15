function [ peaks ] = findAbsolutePeaks(x, globalThreshold)
%FINDPEAKS finds peaks in a function
%   implementation of peaks, that uses only built-ins that can be
%   easily implemented with C++
    peaks = [];
    maxValue = max(abs(x));
    
    i = 1;
    candidate = i;
    while i < size(x, 2)
        if x(i) > globalThreshold * maxValue
            candidate = i;
            currentPeak = x(i);
            while i < size(x, 2)
                if x(i) > currentPeak 
                    currentPeak = x(i);
                    candidate = i;
                elseif x(i) < globalThreshold * maxValue
                    break;
                end
                i = i + 1;
            end
            
            peaks = [peaks candidate];
        end
        
        i = i + 1;
    end
end

