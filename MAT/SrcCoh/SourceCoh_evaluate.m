function Cxy_f = SourceCoh_evaluate(x, t, f)
% Evaluates coherence with a reference sine signal
% at frequency 'f'.
%   'x': Matrix containing time series [nt*n_channels]
%   't': Time array for x [nt*1]

%% Given
fs = 1000;      % Sampling frequency
fi = [f, f];  % Frequency interval

%% Create reference sinusoidal signal
y = sin(2*pi*f*t);

%% Calculate Coherence
Cxy = (mscohere(x, y, [], [], fi, fs))';
Cxy_f = Cxy(:, 1);