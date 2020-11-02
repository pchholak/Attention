function [pm0, pm1, pm2, f0, f] = psd_sub(sub)

%% Given
fscouts = ['D:\Research\Academic\PhD\Perception\' ...
    'Results\SourceLocal\scout_V1_V2']; % Scouts for V1 and V2
root = 'D:\MATLAB\Perception\Trials\';

%% Load scouts
load(fscouts, 'Scouts')
nscouts = length(Scouts);
V = [];
for p=1:nscouts
    V = [V, Scouts(p).Vertices];
end

%% Load trials with Kernel
[X1, ~, K] = loadMEGtrial(sub, 'L', root, 1);
X2 = loadMEGtrial(sub, 'R', root);
X0 = loadMEGtrial(sub, 'B', root);

%% Evaluate VIF
ss0 = average_source_activity(X0, K, V);
ss1 = average_source_activity(X1, K, V);
ss2 = average_source_activity(X2, K, V);

%% Find the FFT
[pm0, f0] = psd_timeseries(ss0);
[pm1, f] = psd_timeseries(ss1);
pm2 = psd_timeseries(ss2);
