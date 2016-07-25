%% Rate score over bandwidth
B = f2(1:4) - f1(1:4);

error = 1 - E(1:4, :);

% u = unique(B);
% g = findgroups(B);
% 
% l = cell(1, length(u));
% l{1, length(u)} = [];
% for k = 1:length(B)
%     l{g(k)} = [l{g(k)}; error(:, k)];
% end

[l, u] = groupBy(error', B, @(x)(x));

emax = zeros(1, length(l));
emin = ones(1, length(l));
emean = zeros(1, length(l));
for k = 1:length(l)
    emax(k) = max(l{k});
    emin(k) = min(l{k});
    emean(k) = mean(l{k});
end

figure();
set(gcf,'numbertitle','off','name','MCOK Byte Error Rate over Total Bandwidth');
title('MCOK Byte Error Rate over Total Bandwidth');
xlabel('B [Hz]'), ylabel('E_{Byte}');
hold all;
errorbar(u, emean, emean-emin, emean-emax, 'x');
axis([2000 8000 -0.1 1.1]);
pbaspect([5 1 1]);
grid on;
hold off;
cleanfigure;
matlab2tikz('mcok-err-bandwidth.tex', 'height', '\figureheight', 'width', '\figurewidth');

%% effect of rolloff factor

error = 1 - E(4:end, :);

% u = unique(B);
% g = findgroups(B);
% 
% l = cell(1, length(u));
% l{1, length(u)} = [];
% for k = 1:length(B)
%     l{g(k)} = [l{g(k)}; error(:, k)];
% end

[l, u] = groupBy(error', rolloff(4:end), @(x)(x));

emax = zeros(1, length(l));
emin = ones(1, length(l));
emean = zeros(1, length(l));
for k = 1:length(l)
    emax(k) = max(l{k});
    emin(k) = min(l{k});
    emean(k) = mean(l{k});
end

figure();
set(gcf,'numbertitle','off','name','MCOK Byte Error Rate over Total Bandwidth');
title('MCOK Byte Error Rate over Rolloff Factor');
xlabel('\beta'), ylabel('E_{Byte}');
hold all;
errorbar(u, emean, emean-emin, emean-emax, 'x');
pbaspect([5 1 1]);
axis([-0.1 1 -0.1 1.1]);
grid on;
hold off;
cleanfigure;
matlab2tikz('mcok-err-rolloff.tex', 'height', '\figureheight', 'width', '\figurewidth');

%% MCOK achievable data rate

%%
Tpacket = ((Tsym(1:4) + Tg(1:4)) * 4 + 5 * Tsym(1:4) + Tg(1:4)) / 1000;
maxAchievable = 2 ./ Tpacket * 15/16 * 2;
fsym = 1./(Tpacket);

%%
midFreq = (f2 + f1) / 2;
effective = mean(R(1:4), 2) ./ maxAchievable(1:4)';

figure();
set(gcf,'numbertitle','off','name','CBOK Data Rage');
plot(fsym, effective, 'x'); 
hold on;
pbaspect([2.5 1 1]);
axis([10 45 -0.1 0.4]);
grid on;

hold off;

legend('measurements', 'fitted curve');
title('MCOK Relative Achievable Data Rate');
xlabel('T_{packet}^{-1} [Hz]'), ylabel('R_{MCOK} / R_{max}');

cleanfigure;
matlab2tikz('mcok-rate-maxachievable.tex', 'height', '\figureheight', 'width', '\figurewidth');
