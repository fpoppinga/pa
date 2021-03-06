function [rc] = raised_cosine(time, tmax, beta)
%SQRT_RAISED_COSINE Returns a raised-cosine with roll-of factor and
%size as specified.

    rc = zeros(1, length(time));
    k = 1;
    w = beta * tmax;
    
    for t = time
        if abs(t) > (1 - beta) * tmax
            phase = (tmax - abs(t)) / w;
            rc(k) = cos(0.5*pi*phase - pi/2);
        elseif abs(t) < tmax
            rc(k) = 1;
        else 
            rc(k) = 0;
        end
        
        k = k + 1;
    end
end

