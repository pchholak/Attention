function [pm1, f] = psd_sub(sub)

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
[X1, t, K] = loadMEGtrial(sub, 'I', root, 1);

%% Evaluate VIF
ss1 = steady_evoked(X1, K, V);

%% Find the FFT
[pm1, f] = psd_timeseries(ss1);
