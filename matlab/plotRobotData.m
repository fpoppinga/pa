correlation = loadBinary('preambleCorrelation.bin');
package1 = loadBinary('package_3.bin');
package2 = loadBinary('package_4.bin');
package3 = loadBinary('package_5.bin');

plot(correlation)

% figure();
% hold all;
%  plot(package1);
%  plot(package2);
%  plot(package3);

% 
% figure();
% subplot(3, 1, 1); plot(timedomain);
% subplot(3, 1, 2); plot(upCorrelation);
% subplot(3, 1, 3); plot(downCorrelation);
% 
