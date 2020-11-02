xxx
sub = 5;
q1 = 3;
q2 = 8;

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
ss1 = steady_evoked(X1, K, V);
ss2 = steady_evoked(X2, K, V);

%% Find the best response frequency near 'f1c' and 'f2c'
f1 = vol_checkPSD(ss1, f1c);
f2 = vol_checkPSD(ss2, f2c);

%% Wavelet energy time series at f1 and f2 for LEFT/RIGHT orientation
Pf11 = morletTF(ss1, t, f1, fc, FWHM_tc); % L-f1
Pf12 = morletTF(ss1, t, f2, fc, FWHM_tc); % L-f2
Pf21 = morletTF(ss2, t, f1, fc, FWHM_tc); % R-f1
Pf22 = morletTF(ss2, t, f2, fc, FWHM_tc); % R-f2

%% Normalise wavelet energy
dE1 = f1*Pf11(q1, :) - f2*Pf12(q1, :);
dE1 = dE1/max(abs(dE1));
dE2 = f1*Pf21(q2, :) - f2*Pf22(q2, :);
dE2 = dE2/max(abs(dE2));

%% Visualise
figure
plot(t, dE1, 'LineWidth', 2)
xlabel('Time (s)', 'Interpreter', 'Latex')
ylabel('$\overline{\Delta E}$', 'Interpreter', 'Latex')
set(gca, 'FontSize', 13)
hline(0, 'k--')

figure
plot(t, dE2, 'LineWidth', 2)
xlabel('Time (s)', 'Interpreter', 'Latex')
ylabel('$\overline{\Delta E}$', 'Interpreter', 'Latex')
set(gca, 'FontSize', 13)
hline(0, 'k--')
