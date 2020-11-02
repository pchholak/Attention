close all
clear
clc

% Given
exc = [8, 11];
subj_indices = 1:17; nsub = length(subj_indices);
info.res_path_coh = '/home/rommel/research/results/perception/Coherence';
keywd = 'Coh(120by3s)';
fscouts = '/home/rommel/data/perception/scout_V1_V2.mat';
K = [4.0807, 4.4821, 4.0067, 3.9300, 2.7739, 2.5521, 2.8468, 3.4994, ...
    3.1721, 2.9328, 3.0600, 4.0513, 2.8507, 3.6662, 3.2144, 3.2878, 2.7215];
N = 1./K; % Noise
label_gap = .005;

% Load scout vertices
load(fscouts)
nscouts = length(Scouts);
V = [];
for p=1:nscouts
    V = [V, Scouts(p).Vertices];
end
info.scout_vert = V;

%% Absolute difference in coherence of areas marked by vertices V
names = cell(1, nsub);
Pm = zeros(1, nsub); Cm = Pm;
for iSubj=subj_indices
    names{iSubj} = num2str(iSubj);
    info.name = sprintf('sub%02d', iSubj);
    [P, C] = SourceDiff_sub(info, keywd);
    Pm(iSubj) = mean(P);
    Cm(iSubj) = mean(C);
end

%% Visualise
figure
[~, lm] = custom_scatter(N, Cm, exc, label_gap, names);
xlabel('Noise'), ylabel('\DeltaC_{avg}')
grid
set(gca, 'FontSize', 14)
pval = lm.Coefficients.pValue; str_pval = sprintf('p-val = %0.3f', pval(2));
text(.62, .85, str_pval, 'Units', 'normalized', 'FontSize', 14, 'Color', 'r')
fname_plot = fullfile(info.res_path_coh, 'Coherence_Noise.png');
saveas(gcf, fname_plot);

% figure
% custom_scatter(N, Pm, exc, label_gap, names);
% xlabel('Noise'), ylabel('P')
% grid
% set(gca, 'FontSize', 14)
