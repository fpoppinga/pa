%%
Tpacket = ((Tsym + Tg) * 2 + 5 * Tsym + Tg) / 1000;
maxAchievable = 1 ./ Tpacket * 0.75 * 2;
fsym = 1./(Tpacket);

%%
effective = mean(R, 2) ./ maxAchievable';

effectivefit = fit(fsym', effective, 'smoothingspline');

figure();
set(gcf,'numbertitle','off','name','CBOK Data Rage');
plot(fsym, effective, 'x'); 
hold on;
fs = min(fsym):0.1:max(fsym);
plot(fs, effectivefit(fs), '-r')
pbaspect([2.5 1 1]);
grid on;

hold off;

legend('measurements', 'fitted curve');
title('CBOK Relative Data Rate');
xlabel('T_{packet}^{-1} [Hz]'), ylabel('R_{relative, CBOK}');

cleanfigure;
matlab2tikz('cbok-rate-maxachievable.tex', 'height', '\figureheight', 'width', '\figurewidth');
%%
errorfit = fit(Tpacket', mean(1-E, 2), 'smoothingspline');

ts = min(Tpacket):0.001:max(Tpacket);
figure();
plot(Tpacket, 1-E, 'xb');
hold on;
plot(ts, errorfit(ts), '-r');
pbaspect([2.5 1 1]);

grid on;
hold off;

legend('measurements', 'fitted curve');
title('CBOK Error Rate vs. Packet Duration');
xlabel('T_{packet} [s]'), ylabel('E_{CBOK}');

cleanfigure;
matlab2tikz('cbok-error-tpacket.tex', 'height', '\figureheight', 'width', '\figurewidth');
