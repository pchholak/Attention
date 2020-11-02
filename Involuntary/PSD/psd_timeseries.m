function [pm, f] = psd_timeseries(vif)
% Returns the FFT

% Given
Fs = 1000;
fbound = 1;

% Windowing
L = size(vif,2);
w = hamming(L); x = vif'.*w;

% FFT
y = fft(x);
p2 = abs(y/L); p1 = p2(1:floor(L/2)+1,:);
p1(2:end-1,:) = 2*p1(2:end-1,:);
pm = mean(p1,2); f = Fs*(0:(L/2))/L;

% Plot
% figure
% plot(f,pm)
% xlim([0 40])
% xlabel('f (Hz)')
% ylabel('|P(f)|')
% vline(f_best,'k--')
% set(gca,'FontSize',14)
