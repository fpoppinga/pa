function [rc] = raised_cosine(time, tmax, beta)
%SQRT_RAISED_COSINE Returns a raised-cosine with roll-of factor and
%size as specified.
%   Detailed explanation goes here
    rc = zeros(1, length(time));
    k = 1;
    for t = time
        if abs(t) < (1 - beta) / (2* tmax)
            rc(k) = 0.5 * (1 + cos(pi * tmax / beta * ((abs(t) - (1-beta)) / (2 * tmax))));
        else
            rc(k) = 1;
        end
        
        k = k + 1;
    end
end

