function f_best = invol_checkPSD(ss,fc)
% Returns the frequency with the highest response in the vicinity of 'fc'

% Given
Fs = 1000;
fbound = 1;

% Windowing
L = size(ss,2);
w = hamming(L); x = ss'.*w;

% FFT
y = fft(x);
p2 = abs(y/L); p1 = p2(1:floor(L/2)+1,:);
p1(2:end-1,:) = 2*p1(2:end-1,:);
pm = mean(p1,2); f = Fs*(0:(L/2))/L;

% Find best responding frequency in the vicinity of 'fc'
jf = find((f>=fc-fbound)&(f<=fc+fbound));
[~,jmax] = max(pm(jf));
f_best = f(jf(jmax));

% Plot
% figure
% plot(f,pm)
% xlim([0 40])
% xlabel('f (Hz)')
% ylabel('|P(f)|')
% vline(f_best,'k--')
% set(gca,'FontSize',14)
