function [tau1, tau2] = invol_sub(sub)

%% Given
fscouts = ['path_to_data\scout_V1_V2']; % Scouts for V1 and V2
root = 'path_to_results\Trials\';
sf = 'I';
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
[X, t, K] = loadMEGtrial(sub, sf, root, 1);

%% Evaluate VIF
vif = steady_evoked(X,K,V);

%% Find the best response frequency of VIF 'ss' near 'f1c' and 'f2c'
f1 = invol_checkPSD(vif, f1c);
f2 = invol_checkPSD(vif, f2c);

%% Wavelet energy time series at f1 and f2 for B and I
Pf1 = morletTF(vif, t, f1, fc, FWHM_tc); % I-f1
Pf2 = morletTF(vif, t, f2, fc, FWHM_tc); % I-f2

%% Normalise by frequency and take difference
dE = f1*Pf1 - f2*Pf2;
dE = dE/max(abs(dE));

%% Switches
sw = invol_switch(dE);
tau1 = invol_duration(sw, 1); % For f1
tau2 = invol_duration(sw, 0); % For f2

%% Visualise
% figure
% plot(t,dE,t,sw,'LineWidth',2)
% xlabel('Time (s)')
% ylabel('\DeltaE/max(|\DeltaE|)')
% set(gca,'FontSize',14)
% legend({'\DeltaE','Switch'},'FontSize',14)

% figure
% subplot(1,2,1)
% histogram(tau1)
% subplot(1,2,2)
% histogram(tau2)
