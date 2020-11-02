function [mu, D1, D2, Pn] = vol_sub(sub)

%% Given
fscouts = ['D:\Research\Academic\PhD\Perception\' ...
    'Results\SourceLocal\scout_V1_V2']; % Scouts for V1 and V2
root = 'D:\MATLAB\Perception\Trials\';
f1c = 120/9; f2c = 120/7;
fc = 1; FWHM_tc = 12;

%% Load scouts
load(fscouts, 'Scouts')
nscouts = length(Scouts);
V = [];
for p=1:nscouts
    V = [V, Scouts(p).Vertices];
end

%% Load trials with Kernel
[X1, t, K] = loadMEGtrial(sub, 'L', root, 1);
X2 = loadMEGtrial(sub, 'R', root);

%% Evaluate VIF
ss1 = average_source_activity(X1, K, V);
ss2 = average_source_activity(X2, K, V);

%% Find the best response frequency near 'f1c' and 'f2c'
f1 = vol_checkPSD(ss1, f1c);
f2 = vol_checkPSD(ss2, f2c);

%% Wavelet energy time series at f1 and f2 for LEFT/RIGHT orientation
Pf11 = morletTF(ss1, t, f1, fc, FWHM_tc); % L-f1
Pf12 = morletTF(ss1, t, f2, fc, FWHM_tc); % L-f2
Pf21 = morletTF(ss2, t, f1, fc, FWHM_tc); % R-f1
Pf22 = morletTF(ss2, t, f2, fc, FWHM_tc); % R-f2

%% Normalise wavelet energy
Pn11 = f1*mean(mean(Pf11)); Pn12 = f2*mean(mean(Pf12));
Pn21 = f1*mean(mean(Pf21)); Pn22 = f2*mean(mean(Pf22));
Pn = [Pn11, Pn12, Pn21, Pn22];

%% Dominance of L over R time series for both frequencies
D1 = (Pn11 - Pn21) / mean([Pn11 Pn21]);
D2 = (Pn12 - Pn22) / mean([Pn12 Pn22]);
sprintf('Mean dominance of L over R in f1: %0.3f', D1)
sprintf('Mean dominance of L over R in f2: %0.3f', D2)

%% Performance
mu = D1 - D2;
sprintf('Performance = %0.3f', mu)
