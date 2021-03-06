%% Rate score over bandwidth
B = f2 - f1;

error = 1 - E;

% u = unique(B);
% g = findgroups(B);
% 
% l = cell(1, length(u));
% l{1, length(u)} = [];
% for k = 1:length(B)
%     l{g(k)} = [l{g(k)}; error(:, k)];
% end

[l, u] = groupBy(error, B, @(x)(x));

emax = zeros(1, length(l));
emin = ones(1, length(l));
emean = zeros(1, length(l));
for k = 1:length(l)
    emax(k) = max(l{k});
    emin(k) = min(l{k});
    emean(k) = mean(l{k});
end

figure();
set(gcf,'numbertitle','off','name','CBOK Byte Error over Bandwidth');
title('CBOK Byte Error Rate over Bandwidth');
xlabel('B [Hz]'), ylabel('E_{Byte}');
hold all;
errorbar(u, emean, emean-emin, emean-emax, 'x');
axis([0 8000 -0.1 1.1]);
pbaspect([5 1 1]);
grid on;
hold off;
cleanfigure;
matlab2tikz('cbok-err-bandwidth.tex', 'height', '\figureheight', 'width', '\figurewidth');

%% error by mid frequency, where B > 2000
midF = (f2(1:end-1) + f1(1:end-1)) / 2;
[l, u] = groupBy(error(1:end-1, :), midF, @(x)(x));

emax = zeros(1, length(l));
emin = ones(1, length(l));
emean = zeros(1, length(l));
for k = 1:length(l)
    emax(k) = max(l{k});
    emin(k) = min(l{k});
    emean(k) = mean(l{k});
end

figure();
set(gcf,'numbertitle','off','name','CBOK Byte Error over Average Frequency');
title('CBOK Byte Error over Average Frequency');
xlabel('f_{12} [Hz]'), ylabel('E_{Byte}');
hold all;
errorbar(u, emean, emean-emin, emean-emax, 'x');
axis([0 8000 -0.02 0.2]);
pbaspect([5 1 1]);
grid on;
hold off;
cleanfigure;
matlab2tikz('cbok-err-meanfreq.tex', 'height', '\figureheight', 'width', '\figurewidth');
