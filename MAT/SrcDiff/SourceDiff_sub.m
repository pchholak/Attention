function [P, dc] = SourceDiff_sub(info, keywd)

% Locate and list .mat files
fmatF = dir([info.res_path_coh, '/', keywd, '*_' info.name '_F.mat']);
fmatB = dir([info.res_path_coh, '/', keywd, '*_' info.name '_B.mat']);

% Load files, average and take difference
load([info.res_path_coh, '/', fmatF(1).name], 'src'); clear fmatF
srcF = mean(src(info.scout_vert, 1, :), 3);
load([info.res_path_coh, '/', fmatB(1).name], 'src'); clear fmatB
srcB = mean(src(info.scout_vert, 1, :),3);

% Evaluate normalized difference of coherence (P)
P = (srcF - srcB) ./ srcB;
dc = srcF - srcB;
