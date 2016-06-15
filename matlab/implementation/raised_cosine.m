function [x] = raised_cosine(ts, fs, beta)
%SQRT_RAISED_COSINE Returns a sqrt-raised-cosine with roll-of factor and
%size as specified.
%   Detailed explanation goes here
    x = rcosdesign(beta, 1, floor(ts * fs) - 1);
end

